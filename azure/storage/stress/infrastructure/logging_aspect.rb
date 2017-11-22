require "aspector"
require_relative "../constants"

# Aspect used as a logging hookup
module Azure
  module Storage
    module Infrastructure
      class LoggingAspect < Aspector::Base
        ALL_METHODS = /.*/
        EXCEPTED = [
          :class,
          :is_a?,
          :respond_to?
        ]

        around ALL_METHODS, except: EXCEPTED, method_arg: true do |method, proxy, *args, &block|
          class_method = "#{self.class}.#{method}"
          LoggingAspect.logger.debug "Entering #{class_method}: #{args.join(',')}"
          begin
            result = proxy.call(*args, &block)
          rescue Exception => e
            LoggingAspect.logger.error "Error in #{class_method} raised with exception: #{e.class}::#{e.message}"
            throw e
          end
          LoggingAspect.logger.debug "Exiting  #{class_method}: #{result}"
          result
        end

        def self.logger
          unless @is_init
            @logger.level = Azure::Storage::Constants::Defaults::LOGGER_LEVEL
            @logger.formatter = proc do |sev, datetime, progname, msg|
              date_format = datetime.utc.strftime("%Y-%m-%d %H:%M:%S.%L")
              if sev == "INFO" || sev == "WARN"
                "[#{date_format}] #{sev} : #{msg}\n"
              else
                "[#{date_format}] #{sev}: #{msg}\n"
              end
            end
            @logger.info "Logger initalized."
            @is_init = true
          end
          @logger
        end
      end
    end
  end
end

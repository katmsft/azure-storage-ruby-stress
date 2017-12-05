require "aspector"
require "thread"
require_relative "../constants"

# Aspect used as a logging hookup
module Azure::Storage::Stress
  module Infrastructure
    class LoggingAspect < Aspector::Base
      ALL_METHODS = /.*/
      EXCEPTED = [
        :class,
        :is_a?,
        :respond_to?
      ]

      around ALL_METHODS, except: EXCEPTED, method_arg: true do |method, proxy, *args, &block|
        class_method = "#{self.class}::#{method}"
        callerStr = caller_locations[1].to_s
        LoggingAspect.logger.debug "Called by #{callerStr}, Entering #{class_method}: #{args.join(',')}"
        begin
          result = proxy.call(*args, &block)
        rescue Exception => e
          LoggingAspect.logger.error "Error in #{class_method} raised with exception: #{e.inspect}"
          backtraceStr = e.backtrace.join("\n")
          LoggingAspect.logger.error "Trace:\n#{backtraceStr}"
          raise e
        end
        LoggingAspect.logger.debug "Exiting  #{class_method}: #{result}"
        result
      end

      def self.logger
        unless @is_init
          @logger.level = XSS::Constants::Defaults::LOGGER_LEVEL
          @logger.formatter = proc do |sev, datetime, progname, msg|
            date_format = datetime.utc.strftime("%Y-%m-%d %H:%M:%S.%L")
            # Remove the class::method information
            msg.slice!(0..msg.index(" | ") + 2)
            # Adding caller location
            if sev == "DEBUG" || sev == "INFO"
              # magic number 4 is the place where the actual caller where the logging happens for debug and info.
              unless caller_locations[4].to_s.include? "logging_aspect.rb"
                msg = caller_locations[4].to_s + " | " + msg
              end
            end
            # Getting thread ID
            id = Thread.current.object_id
            if sev == "INFO" || sev == "WARN"
              "[#{date_format}][Thread: #{id}] #{sev} : #{msg}\n"
            else
              "[#{date_format}][Thread: #{id}] #{sev}: #{msg}\n"
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
require "thrift"
require "aspector"
require_relative "../auto_generated/core_types"
require_relative "../utils"
require_relative "logging_aspect"

module Azure::Storage::Stress
  module Infrastructure
    class ProcessorFactory
      include ::Thrift::Processor
      def initialize(processor_type, handler_type)
        super nil
        @handler_type = handler_type
        @processor_type = processor_type
        LoggingAspect.apply(self)
      end

      def process(iprot, oprot)
        handler = @handler_type.new
        LoggingAspect.apply(handler)
        processor = @processor_type.new(handler)
        LoggingAspect.apply(processor)
        wrap_out_protocol(oprot, handler)
        processor.process(iprot, oprot)
      end

      def wrap_out_protocol(oprot, handler)
        LoggingAspect.logger.debug "Wrapping out_protocol in aspect so request_info gets written"
        aspector(oprot) do
          around :write_message_begin do |proxy, *args, &block|
            proxy.call *args, &block
            LoggingAspect.logger.debug "Writing request_info to out_protocol"
            handler.request_info.write(oprot)
          end
        end
      end
    end
  end
end

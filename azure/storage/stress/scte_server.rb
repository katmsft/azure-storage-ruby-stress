require "thrift"
require_relative "service_handlers"
require_relative "./infrastructure/processor_factory"
require_relative "./infrastructure/logging_aspect"
require "aspector"

LoggingAspect = XSS::Infrastructure::LoggingAspect

multiplexed = Thrift::MultiplexedProcessor.new

moduleName = Azure::Storage::Stress::Constants::Service

# Register the service with processor and handlers
constantsArray = moduleName.constants
constantsArray.each { |constant|
  constant = constant.to_s
  service = "XSS::Constants::Service::" + constant
  processor = constant == "SupportedFeatures" ? "XSS::AutoGenerated::" + constant + "::Processor" : "XSS::AutoGenerated::" + constant + "Service::Processor"
  handler = "XSS::Handler::" + constant + "Handler"
  multiplexed.register_processor(
    Object.const_get(service),
    XSS::Infrastructure::ProcessorFactory.new(
      Object.const_get(processor),
      Object.const_get(handler)
    )
  )
}

transport = Thrift::ServerSocket.new("0.0.0.0", 9993)

server = Thrift::ThreadedServer.new(multiplexed, transport, Thrift::FramedTransportFactory.new, Thrift::BinaryProtocolFactory.new)
LoggingAspect.apply(server)
server.serve()

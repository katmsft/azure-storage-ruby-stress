require "thrift"
require_relative "service_handlers"
require_relative "./infrastructure/logging_aspect"
require_relative "utils"

def bin_to_hex(s)
  s.each_byte.map { |b| b.to_s(16) }.join
end

# Azure::Storage::Stress::Infrastructure::LoggingAspect.apply(Azure::Storage::Stress::Utilities)
# Azure::Storage::Stress::Infrastructure::LoggingAspect.apply(Azure::Storage::Stress::Utilities)
# Azure::Storage::Stress::Infrastructure::LoggingAspect::debug("start")
# bin_to_hex(Azure::Storage::Stress::Utilities.generateMT19937Payload(2000000, 7))
# Azure::Storage::Stress::Infrastructure::LoggingAspect::debug("end")
# Azure::Storage::Stress::Infrastructure::LoggingAspect::debug("start")
# bin_to_hex(Azure::Storage::Stress::Utilities.generateMT19937PayloadSlow(2000000, 7))
# Azure::Storage::Stress::Infrastructure::LoggingAspect::debug("end")

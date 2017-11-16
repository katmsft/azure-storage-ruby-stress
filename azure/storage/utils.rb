require_relative "./auto_generated/core_types"
require "time"

module Azure
  module Storage
    module Utilities
      def self.get_default_request_info
        Azure::Storage::AutoGenerated::InternalRequestInformation.new("uri" => "", "statusCode" => 0, "httpVerb" => "", "statusDescription" => "")
      end

      def self.timeStringToInteger(timeString)
        temp = Time.parse(timeString)
        return temp.to_i()
      end

      def self.timeStampToTime(time)
        timeStamp = (time / Azure::Storage::Constants::Constant::TICKS_PER_MILLISECOND - Azure::Storage::Constants::Constant::UNIX_EPOCH_IN_MILLISECONDS) / Azure::Storage::Constants::Constant::MILLISECONDS_PER_SECOND
        return Time.at(timeStamp)
      end

      def self.timeSpanToSecond(timeSpan)
        return timeSpan / Azure::Storage::Constants::Constant::TICKS_PER_SECOND
      end
    end
  end
end

require_relative "./auto_generated/core_types"
require_relative "constants"
require "time"

module Azure::Storage::Stress
  module Utilities
    def self.get_default_request_info
      XSS::AutoGenerated::InternalRequestInformation.new("uri" => "", "statusCode" => 0, "httpVerb" => "", "statusDescription" => "")
    end

    def self.timeStringToInteger(timeString)
      time = Time.parse(timeString).utc
      seconds = time.to_i
      nano_seconds = time.nsec
      (seconds * XSS::Constants::TICKS_PER_SECOND) + (nano_seconds / XSS::Constants::NANO_SECONDS_PER_TICK) + XSS::Constants::UNIX_EPOCH_IN_TICKS
    end

    def self.timeIntegerToEdmString(timeInt)
      ticks = timeInt - XSS::Constants::UNIX_EPOCH_IN_TICKS
      sec = self.timeSpanToSecond(ticks)
      frac = (ticks - (sec * XSS::Constants::TICKS_PER_SECOND)).to_s.rjust(7, "0") + "Z"
      Time.at(sec).utc.strftime("%Y-%m-%dT%H:%M:%S.") + frac
    end

    def self.datetimeToEdmString(datetime)
      timeIntegerToEdmString(datetime.to_i)
    end

    def self.timeStampToTime(time)
      timeStamp = (time / XSS::Constants::TICKS_PER_MILLISECOND - XSS::Constants::UNIX_EPOCH_IN_MILLISECONDS) / XSS::Constants::MILLISECONDS_PER_SECOND
      return Time.at(timeStamp)
    end

    def self.timeSpanToSecond(timeSpan)
      return timeSpan / XSS::Constants::TICKS_PER_SECOND
    end

    def self.getCurrentTimeInTicks()
      (Time.now.utc.to_f * XSS::Constants::TICKS_PER_SECOND).to_i
    end

    def self.metadataFromHeaders(headers)
      metadata = {}
      headers.each { |k, v|
        if key = k[/^x-ms-meta-(.*)/, 1]
          if metadata.has_key? key
            metadata[key] = [metadata[key]] unless metadata[key].respond_to? :push
            metadata[key].push(v)
          else
            metadata[key] = v
          end
        end
      }
      metadata
    end

    def self.thriftizeString(moduleName, string, default = 0)
      return default if string.nil? || string.empty?
      constantsArray = moduleName.constants
      constantsArray.each { |constant| return moduleName.const_get(constant) if constant.to_s.casecmp(string) == 0 }
      default
    end

    def self.getConstNameFromModule(moduleName, const_value)
      constantsArray = moduleName.constants
      constantsArray.each { |constant| return constant.to_s if moduleName.const_get(constant) == const_value }
      # Return the first value if could not get.
      constantsArray[0].to_s
    end

    def self.generateMT19937Payload(length, seed)
      random = ::Random.new(seed)
      payload = Array.new(length)
      for i in 0...length
        payload[i] = random.rand(256)
      end
      payload[0] = seed
      payload.pack("C*")
    end

    def self.generateMT19937PayloadSlow(length, seed)
      random = ::Random.new(seed)
      payload = "#{seed.chr}"
      random.rand(256)
      for i in 1...length
        payload += random.rand(255).chr
      end
      payload
    end

    def self.generateMT19937PayloadFromArrays(segments, versions)
      payload = ""
      for idx in 0...versions.size
        payload += generateMT19937Payload(segments[idx], versions[idx])
      end
      payload
    end
  end
end

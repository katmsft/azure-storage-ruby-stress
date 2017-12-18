require "azure/core/http/http_filter"
require "time"
require_relative "../utils"
require_relative "logging_aspect"

module Azure::Storage::Stress
  module Infrastructure
    class RequestInfoFilter < Azure::Core::Http::HttpFilter
      def initialize(requestInfo, &block)
        super()
        @requestInfo = requestInfo || XSS::Utilities::get_default_request_info
      end

      def call(req, _next)
        @requestInfo.uri               = req.uri
        @requestInfo.httpVerb          = req.method
        @requestInfo.requestHeaders    = req.headers
        @requestInfo.startTime         = Time.now.utc.to_i

        begin
          r = _next.call
        rescue Azure::Core::Http::HTTPError => e
          r = e.http_response
        end

        @requestInfo.statusCode        = r.status_code.to_i
        @requestInfo.statusDescription = r.status_code.to_s
        @requestInfo.responseHeaders   = r.headers
        @requestInfo.clientRequestId   = r.headers["x-ms-request-id"]
        @requestInfo.endTime           = Time.now.utc.to_i
        @requestInfo.contentLength     = r.headers["Content-Length"] || r.headers["content-length"]
        @requestInfo.requestResults    = build_request_result(req, r)
        raise e unless e.nil?
        printDebugLogRequestInfo(@requestInfo)
        # Print body if short enough.
        LoggingAspect::logger.debug("Response body is #{r.body}") if r.body.size < 2048
        r
      end

      def build_request_result(request, response)
        # TODO: build an actual request result if needed
        nil
      end

      def printDebugLogRequestInfo(rInfo)
        LoggingAspect::logger.debug("Request successful")
        LoggingAspect::logger.debug("Request URI is #{@requestInfo.uri.to_s}")
        LoggingAspect::logger.debug("Request httpVerb is #{@requestInfo.httpVerb.to_s}")
        LoggingAspect::logger.debug("Request headers is #{@requestInfo.requestHeaders.to_s}")
        LoggingAspect::logger.debug("Request ID is #{@requestInfo.clientRequestId.to_s}")
        LoggingAspect::logger.debug("Request content-length is #{@requestInfo.contentLength.to_s}")
        LoggingAspect::logger.debug("Response status code is #{@requestInfo.statusCode.to_s}")
        LoggingAspect::logger.debug("Response status description is #{@requestInfo.statusDescription.to_s}")
        LoggingAspect::logger.debug("Response headers is #{@requestInfo.responseHeaders.to_s}")
      end
    end
  end
end

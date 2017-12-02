require "azure/core/http/http_filter"
require "time"
require_relative "../utils"

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
        @requestInfo.clientRequestId   = r.headers["x-ms-client-request-id"]
        @requestInfo.endTime           = Time.now.utc.to_i
        @requestInfo.contentLength     = r.headers["Content-Length"] || r.headers["content-length"]
        @requestInfo.requestResults    = build_request_result(req, r)
        raise e unless e.nil?
        r
      end

      def build_request_result(request, response)
        # TODO: build an actual request result if needed
        nil
      end
    end
  end
end

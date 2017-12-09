require_relative "../auto_generated/core_types"
require_relative "../infrastructure/request_info_filter"

module Azure::Storage::Stress
  module Handler
    class BaseHandler
      attr_accessor :request_info

      def initialize(request_info = nil)
        @request_info = request_info || XSS::Utilities::get_default_request_info
      end

      def build_client(internalRequestInfo, accountInfo, buildClientCallable)
        buildClientCallable(self, accountInfo, [self.get_request_info_filter(internalRequestInfo)])
      end

      def get_request_info_filter(request_info)
        XSS::Infrastructure::RequestInfoFilter.new(request_info)
      end
    end
  end
end

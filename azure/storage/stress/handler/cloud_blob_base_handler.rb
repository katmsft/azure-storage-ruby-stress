require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudBlobBaseHandler < BaseHandler
      def build_client(internalRequestInfo, accountInfo)
        # ==== Build Client ==== #
        XSS::Converter::BlobConverter.getBlobService(self, accountInfo, [self.get_request_info_filter(internalRequestInfo)])
      end
    end
  end
end

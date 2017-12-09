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
        super(internalRequestInfo, accountInfo, XSS::Converter::BlobConverter::getBlobService)
      end
    end
  end
end

require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudFileBaseHandler < BaseHandler
      def build_client(internalRequestInfo, accountInfo)
        # ==== Build Client ==== #
        XSS::Converter::FileConverter.getFileService(self, accountInfo, [self.get_request_info_filter(internalRequestInfo)])
      end
    end
  end
end

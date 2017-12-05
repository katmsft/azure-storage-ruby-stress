require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_directory_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudFileDirectoryHandler < CloudFileBaseHandler
      def createDirectory(accountInfo, filePath, createIfNotExists, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end


      def deleteDirectory(accountInfo, filePath, deleteIfExists, accessCondition, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end


      def setMetadata(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext, metadata)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def fetchAttributes(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def exists(accountInfo, filePath, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def listFilesAndDirectories(accountInfo, prefix, filePath, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def listFilesAndDirectoriesSegmented(accountInfo, prefix, filePath, maxResults, continuationToken, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end
    end
  end
end

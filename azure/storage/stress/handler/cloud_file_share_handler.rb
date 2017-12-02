require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_share_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudFileShareHandler < BaseHandler
      def createShare(accountInfo, shareName, createIfNotExists, snapshotTime, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def deleteShare(accountInfo, shareName, deleteIfExists, snapshotTime, deleteSnapshotOptions, accessCondition, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def fetchAttributes(accountInfo, shareName, snapshotTime, accessCondition, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def exists(accountInfo, shareName, snapshotTime, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def setMetadata(accountInfo, shareName, metadata, snapshotTime, accessCondition, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def setProperties(requestInfo, accountInfo, properties)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def setPermissions(reqInfo, accountInfo, permissions)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def getPermissions(reqInfo, accountInfo)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def getShareStats(shareName, snapshotTime, fileRequestOptions, thriftOperationContext, accountInfo)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def snapshotShare(accountInfo, shareName, metadata, snapshotTime, accessCondition, fileRequestOptions, operationContext)
        fileClient = XSS::Converter::FileConverter.getFileService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end
    end
  end
end

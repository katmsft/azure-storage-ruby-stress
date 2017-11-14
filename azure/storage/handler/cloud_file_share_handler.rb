require_relative "base_handler"
require_relative "../auto_generated/core_types"
require_relative "../auto_generated/cloud_queue_client_types"
# require_relative "../auto_generated/cloud_queue_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/queue_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudFileShareHandler < BaseHandler
        def createShare(accountInfo, shareName, createIfNotExists, snapshotTime, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def deleteShare(accountInfo, shareName, deleteIfExists, snapshotTime, deleteSnapshotOptions, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def fetchAttributes(accountInfo, shareName, snapshotTime, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def exists(accountInfo, shareName, snapshotTime, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setMetadata(accountInfo, shareName, metadata, snapshotTime, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setProperties(requestInfo, accountInfo, properties)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setPermissions(reqInfo, accountInfo, permissions)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getPermissions(reqInfo, accountInfo)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getShareStats(shareName, snapshotTime, fileRequestOptions, thriftOperationContext, accountInfo)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def snapshotShare(accountInfo, shareName, metadata, snapshotTime, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

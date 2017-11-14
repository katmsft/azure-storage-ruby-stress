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
      class CloudFileHandler < BaseHandler
        def create(accountInfo, filePath, size, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def writeRange(accountInfo, filePath, version, length, startOffset, contentMd5, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def deleteFile(accountInfo, filePath, deleteIfExists, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def setMetadata(accountInfo, filePath, metadata, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def setProperties(accountInfo, filePath, properties, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def fetchAttributes(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def exists(accountInfo, filePath, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def clearRange(accountInfo, filePath, offset, length, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def resize(accountInfo, filePath, size, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def listRanges(accountInfo, filePath, size, length, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def uploadFromStream(accountInfo, filePath, source, length, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def uploadFromByteArray(accountInfo, filePath, buffer, index, count, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadToByteArray(accountInfo, filePath, targetSize, index, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadRangeToByteArray(accountInfo, filePath, targetSize, index, fileOffset, length, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def startCopyFromFileOrBlob(requestInfo, accountInfo, uri)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_directory_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudFileDirectoryHandler < BaseHandler
        def createDirectory(accountInfo, filePath, createIfNotExists, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def deleteDirectory(accountInfo, filePath, deleteIfExists, accessCondition, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def setMetadata(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext, metadata)
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



        def listFilesAndDirectories(accountInfo, prefix, filePath, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def listFilesAndDirectoriesSegmented(accountInfo, prefix, filePath, maxResults, continuationToken, fileRequestOptions, operationContext)
          fileClient = Azure::Storage::Converter::FileConverter.getFileService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_blob_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudBlobClientHandler < BaseHandler
        def listBlobs(listBlobsPayload, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def listBlobsSegmented(listBlobsPayload, accountInfo, maxResults, currentToken)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def listContainers(listContainersPayload, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def listContainersSegmented(listContainersPayload, accountInfo, maxResults, currentToken)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setProperties(thriftRequestOptions, accountInfo, thriftOperationContext, properties)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getProperties(thriftRequestOptions, accountInfo, thriftOperationContext)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def getServiceStats(thriftRequestOptions, accountInfo, thriftOperationContext)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

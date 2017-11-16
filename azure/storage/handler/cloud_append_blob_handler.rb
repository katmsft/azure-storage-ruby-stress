require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_append_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudAppendBlobHandler < BaseHandler
        def create(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def appendBlockFromByteArray(requestPayload, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def appendBlockFromStream(requestInfo, accountInfo, buffer, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

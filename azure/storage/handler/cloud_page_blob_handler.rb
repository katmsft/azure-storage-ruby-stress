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
      class CloudPageBlobHandler < BaseHandler
        def create(requestInfo, accountInfo, size)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def resize(requestInfo, accountInfo, size)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setSequenceNumber(requestInfo, accountInfo, sequenceNumberAction, sequenceNumber)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def writePages(writePagesPayload, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def clearPages(requestInfo, accountInfo, startOffset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getPageRanges(requestInfo, accountInfo, offset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getPageRangesDiff(requestInfo, accountInfo, offset, length, previous)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def uploadFromStream(requestInfo, accountInfo, source, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def uploadFromFile(requestInfo, accountInfo, path, fileMode)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def startIncrementalCopy(requestInfo, accountInfo, uri)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setPremiumPageBlobTier(requestInfo, accountInfo, premiumPageBlobTier)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

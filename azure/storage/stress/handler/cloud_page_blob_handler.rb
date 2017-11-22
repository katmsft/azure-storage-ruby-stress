require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_page_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudPageBlobHandler < BaseHandler
        def create(requestInfo, accountInfo, size)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def resize(requestInfo, accountInfo, size)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def setSequenceNumber(requestInfo, accountInfo, sequenceNumberAction, sequenceNumber)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end


        def writePages(writePagesPayload, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def clearPages(requestInfo, accountInfo, startOffset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def getPageRanges(requestInfo, accountInfo, offset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def getPageRangesDiff(requestInfo, accountInfo, offset, length, previous)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def uploadFromStream(requestInfo, accountInfo, source, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def uploadFromFile(requestInfo, accountInfo, path, fileMode)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def startIncrementalCopy(requestInfo, accountInfo, uri)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def setPremiumPageBlobTier(requestInfo, accountInfo, premiumPageBlobTier)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end
      end
    end
  end
end

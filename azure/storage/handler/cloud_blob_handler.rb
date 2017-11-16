require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudBlobHandler < BaseHandler
        def deleteBlob(requestInfo, accountInfo, deleteIfExists, isPermanentDelete, deleteSnapshotsOption)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def exists(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def setMetadata(requestInfo, accountInfo, metadata)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setProperties(requestInfo, accountInfo, properties)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def fetchAttributes(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadToStream(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadRangeToStream(requestInfo, accountInfo, offset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def downloadToByteArray(requestInfo, accountInfo, targetSize, index)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadRangeToByteArray(requestInfo, accountInfo, targetSize, index, offset, length)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def uploadFromByteArray(requestInfo, accountInfo, buffer, index, count)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def downloadToFile(requestInfo, accountInfo, path, fileMode)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def acquireLease(requestInfo, accountInfo, leaseTime, proposedLeaseId)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def breakLease(requestInfo, accountInfo, breakPeriod)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def changeLease(requestInfo, accountInfo, proposedLeaseId)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def releaseLease(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end


        def renewLease(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def startCopyFromBlob(requestInfo, accountInfo, uri)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def abortCopy(requestInfo, accountInfo, copyId)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def createSnapshot(requestInfo, accountInfo, metadata)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def undelete(requestInfo, accountInfo)
          blobClient = Azure::Storage::Converter::BlobConverter.getBlobService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

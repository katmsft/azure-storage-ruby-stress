require "azure/storage"
require_relative "core_converter"
require_relative "../infrastructure/logging_aspect"
require_relative "../auto_generated/blob_types_types"
require_relative "../utils"


module Azure::Storage::Stress
  module Converter
    class BlobConverter
      def self.getBlobService(handler, accountInfo, filters = [])
        storageService = XSS::Converter::CoreConverter.getStorageService(handler, accountInfo)
        blob_client = storageService.blob_client
        filters.each { |filter| blob_client.with_filter(filter) }
        blob_client
      end

      def self.getRequestOptions(thriftBlobRequestOptions)
        # TODO: DisableContentMD5Validation, maximumExecutionTimeSeconds, singleBlobUploadThresholdBytes, storeBlobContentMD5, useTransactionalMD5, absorbConditionalErrorsOnRetry, parallelOperationThreadCount
        options = XSS::Converter::CoreConverter::getRequestOptions(thriftBlobRequestOptions)
      end

      def self.buildCloudBlobResponseFromInternalRequestInfo(rInfo)
        result = XSS::AutoGenerated::CloudBlobResponse.new

        result.etag = rInfo.responseHeaders["etag"] unless rInfo.responseHeaders["etag"].nil?

        result.lastModified = XSS::Utilities::timeStringToInteger(rInfo.responseHeaders["last-modified"]) unless rInfo.responseHeaders["last-modified"].nil?

        result.metadata = XSS::Utilities::metadataFromHeaders(rInfo.responseHeaders)

        result.leaseStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseStatus, rInfo.responseHeaders["x-ms-lease-status"])

        result.leaseState = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseState, rInfo.responseHeaders["x-ms-lease-state"])

        result.leaseDuration = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseDuration, rInfo.responseHeaders["x-ms-lease-duration"])

        cacheControl = rInfo.responseHeaders["x-ms-blob-cache-control"] || rInfo.responseHeaders["cache-control"]
        result.cacheControl = cacheControl unless cacheControl.nil? || cacheControl.empty?

        contentDisposition = rInfo.responseHeaders["x-ms-blob-content-disposition"] || rInfo.responseHeaders["Content-Disposition"]
        result.contentDisposition = contentDisposition unless contentDisposition.nil? || contentDisposition.empty?

        contentEncoding = rInfo.responseHeaders["x-ms-blob-content-encoding"] || rInfo.responseHeaders["Content-Encoding"]
        result.contentEncoding = contentEncoding unless contentEncoding.nil? || contentEncoding.empty?

        contentLanguage = rInfo.responseHeaders["x-ms-blob-content-language"] || rInfo.responseHeaders["Content-Language"]
        result.contentLanguage = contentLanguage unless contentLanguage.nil? || contentLanguage.empty?

        length = rInfo.responseHeaders["x-ms-blob-content-length"] || rInfo.responseHeaders["Content-Length"]
        result.length = length.to_i unless length.nil? || length.empty?

        contentMd5 = rInfo.responseHeaders["x-ms-blob-content-md5"] || rInfo.responseHeaders["Content-MD5"]
        result.contentMd5 = contentMd5 unless contentMd5.nil? || contentMd5.empty?

        contentType = rInfo.responseHeaders["x-ms-blob-content-type"] || rInfo.responseHeaders["Content-Type"]
        result.contentType = contentType unless contentType.nil? || contentType.empty?

        result.blobType = XSS::Utilities::thriftizeString(XSS::AutoGenerated::BlobType, rInfo.responseHeaders["x-ms-blob-type"])

        result.PageBlobSequenceNumber = rInfo.responseHeaders["x-ms-blob-sequence-number"].to_i if rInfo.responseHeaders["x-ms-blob-sequence-number"]

        result.snapshotTime = XSS::Utilities::timeStringToInteger(rInfo.responseHeaders["x-ms-snapshot"]) unless rInfo.responseHeaders["x-ms-snapshot"].nil?

        result.copyState = XSS::Converter::CoreConverter::getCopyStateFromInternalRequestInfo(rInfo)

        result.isIncrementalCopy = rInfo.responseHeaders["x-ms-incremental-copy"].to_s == "true" unless rInfo.responseHeaders["x-ms-incremental-copy"].nil?

        # TODO: 2017-04-17
        # result.standardBlobTier
        # result.premiumPageBlobTier
        # result.rehydrationStatus
        # result.blobTierInferred

        # TODO: Soft delete
        # result.isSnapshot
        # result.isDeleted
        # result.deletedTime

        result
      end

      def self.buildCloudBlobResponseFromBlob(blob)
        result = XSS::AutoGenerated::CloudBlobResponse.new

        result.etag = blob.properties[:etag] if blob.properties[:etag]

        result.lastModified = XSS::Utilities::timeStringToInteger(blob.properties[:last_modified]) if blob.properties[:last_modified]

        result.metadata = blob.metadata

        result.leaseStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseStatus, blob.properties[:lease_status])

        result.leaseState = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseState, blob.properties[:lease_state])

        result.leaseDuration = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseDuration, blob.properties[:lease_duration])

        result.cacheControl = blob.properties[:cache_control] if blob.properties[:cache_control]

        result.contentDisposition = blob.properties[:content_disposition] if blob.properties[:content_disposition]

        result.contentEncoding = blob.properties[:content_encoding] if blob.properties[:content_encoding]

        result.contentLanguage = blob.properties[:content_language] if blob.properties[:content_language]

        result.length = blob.properties[:content_length] if blob.properties[:content_length]

        result.contentMd5 = blob.properties[:content_md5] if blob.properties[:content_md5]

        result.contentType = blob.properties[:content_type] if blob.properties[:content_type]

        result.blobType = XSS::Utilities::thriftizeString(XSS::AutoGenerated::BlobType, blob.properties[:blob_type])

        result.PageBlobSequenceNumber = blob.properties[:sequence_number].to_i if blob.properties[:sequence_number]

        result.snapshotTime = XSS::Utilities::timeStringToInteger(blob.snapshot) if blob.snapshot

        result.copyState = XSS::Converter::BlobConverter::getCopyStateFromBlob(blob)

        result.isIncrementalCopy = blob.properties[:incremental_copy].to_s == "true" if blob.properties[:incremental_copy]
      end

      def self.getCopyStateFromBlob(blob)
        return nil if blob.properties[:copy_id].nil? ||blob.properties[:copy_id].empty?
        copyState = XSS::AutoGenerated::ThriftCopyState.new
        copyState.copyID = blob.properties[:copy_id]
        # TODO: assign bytesCopied and totalByte when available.
        copyState.completionTime = XSS::Utilities::timeStringToInteger(blob.properties[:copy_completion_time]) if blob.properties[:copy_completion_time]
        # TODO: assign URI when available
        copyState.copyStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::ThriftCopyStatus, blob.properties[:copy_status]) if blob.properties[:copy_status]
        copyState.statusDescription = blob.properties[:copy_status_description] if blob.properties[:copy_status_description]
        # TODO: copyDestinationSnapshotID
        copyState
      end

      def self.buildBlobContainerResponseFromInternalRequestInfo(rInfo)
        result = XSS::AutoGenerated::BlobContainerResponse.new

        result.etag = rInfo.responseHeaders["etag"] unless rInfo.responseHeaders["etag"].nil?

        result.lastModified = XSS::Utilities::timeStringToInteger(rInfo.responseHeaders["last-modified"]) unless rInfo.responseHeaders["last-modified"].nil?

        result.metadata = XSS::Utilities::metadataFromHeaders(rInfo.responseHeaders)

        result.leaseStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseStatus, rInfo.responseHeaders["x-ms-lease-status"])

        result.leaseState = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseState, rInfo.responseHeaders["x-ms-lease-state"])

        result.leaseDuration = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseDuration, rInfo.responseHeaders["x-ms-lease-duration"])

        result.publicAccessType = XSS::Utilities::thriftizeString(XSS::AutoGenerated::BlobContainerPublicAccessType, rInfo.responseHeaders["x-ms-blob-public-access"])

        result
      end

      def self.buildCloudContainerResponseFromContainer(container)
        result = XSS::AutoGenerated::BlobContainerResponse.new

        result.etag = container.properties[:etag] if container.properties[:etag]

        result.lastModified = XSS::Utilities::timeStringToInteger(container.properties[:last_modified]) if container.properties[:last_modified]

        result.metadata = container.metadata

        result.leaseStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseStatus, container.properties[:lease_status])

        result.leaseState = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseState, container.properties[:lease_state])

        result.leaseDuration = XSS::Utilities::thriftizeString(XSS::AutoGenerated::LeaseDuration, container.properties[:lease_duration])

        result.publicAccessType = XSS::Utilities::thriftizeString(XSS::AutoGenerated::BlobContainerPublicAccessType, container.public_access_level)

        result
      end

      def self.getAccessTypeFromBlobContainerPublicAccessType(accessType)
        case accessType
        when XSS::AutoGenerated::BlobContainerPublicAccessType::Container
          "container"
        when XSS::AutoGenerated::BlobContainerPublicAccessType::Blob
          "blob"
        else
          nil
        end
      end

      def self.convertSequenceNumberAction(sequenceNumberAction)
        case sequenceNumberAction
        when XSS::AutoGenerated::SequenceNumberAction::Increment
          :increment
        when XSS::AutoGenerated::SequenceNumberAction::Max
          :max
        when XSS::AutoGenerated::SequenceNumberAction::Update
          :update
        else
          nil
        end
      end

      def self.buildPageRangesFromListRangeResult(listResult)
        result = []
        listResult.each { |range|
          thriftRange = XSS::AutoGenerated::ThriftPageRange.new
          thriftRange.startOffset = range[0]
          thriftRange.endOffset = range[1]
          result.push thriftRange
        }
        result
      end

      def self.getBlobContinuationToken(nextMarker, uri)
        r = XSS::AutoGenerated::ThriftBlobContinuationToken.new
        r.targetLocation = uri.to_s.include?("-secondary") ? XSS::AutoGenerated::StorageLocation::Secondary : XSS::AutoGenerated::StorageLocation::Primary
        r.nextMarker = nextMarker
        r
      end

      def self.getListDetailOptionsFromThriftBlobListingDetails(thriftListingDetails)
        options = {}
        options[:snapshots] = true if thriftListingDetails & XSS::AutoGenerated::ThriftBlobListingDetails::Snapshots
        options[:metadata] = true if thriftListingDetails & XSS::AutoGenerated::ThriftBlobListingDetails::Metadata
        options[:uncomittedblobs] = true if thriftListingDetails & XSS::AutoGenerated::ThriftBlobListingDetails::UncommittedBlobs
        options[:copy] = true if thriftListingDetails & XSS::AutoGenerated::ThriftBlobListingDetails::Copy
        options
      end

      def self.buildListBlobItemWithBlobContainerAndClient(blob, container, client)
        item = XSS::AutoGenerated::ListBlobItem.new
        blobPath = blob.name + "/" + container
        item.uri = XSS::Converter::CoreConverter::getCloudStorageUriWithClientAndPath(client, blobPath)
        item.parentContainerUri = XSS::Converter::CoreConverter::getCloudStorageUriWithClientAndPath(client, container)
        item.blobProperties = self.buildCloudBlobResponseFromBlob(blob)
        item
      end

      def self.buildCloudBlobContainerWithContainerAndClient(container, client)
        cloudBlobContainer = XSS::AutoGenerated::ThriftCloudBlobContainer.new
        cloudBlobContainer.uri = XSS::Converter::CoreConverter::getCloudStorageUriWithClientAndPath(client, container.name)
        cloudBlobContainer.name = container.name
        cloudBlobContainer.properties = self.buildCloudContainerResponseFromContainer(container)
        cloudBlobContainer.serviceClientUri = XSS::Converter::CoreConverter::getCloudStorageUriWithClientAndPath(client, "")
        cloudBlobContainer.metadata = container.metadata
        cloudBlobContainer
      end

      def self.buildBlobListFromThriftArray(blockList)
        result = []
        blockList.each { |block| result.push([block, :uncommitted]) } # TODO: What about uncommitted?
        result
      end

      def self.getBlockListTypeFromBlockListingFilters(blockListingFilters)
        case blockListingFilters
        when XSS::AutoGenerated::BlockListingFilters::All
          :all
        when XSS::AutoGenerated::BlockListingFilters::Committed
          :committed
        when XSS::AutoGenerated::BlockListingFilters::Uncommitted
          :uncommitted
        else
          nil
        end
      end

      def self.buildListBlockItemWithBlock(block)
        listBlockItem = XSS::AutoGenerated::ListBlockItem.new
        listBlockItem.committed = (block.type == :committed)
        listBlockItem.length = block.size
        listBlockItem.name = block.name
        listBlockItem
      end
    end
  end
end

require_relative "base_handler"
require_relative "cloud_blob_base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_page_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudPageBlobHandler < CloudBlobHandler
      def create(requestInfo, accountInfo, size)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Creating page blob #{containerName}\\#{blobName} with size #{size}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.create_page_blob(containerName, blobName, size, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Page blob #{containerName}\\#{blobName} with size #{size} created")
        r = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
        r.length = size
        r
      end

      def resize(requestInfo, accountInfo, size)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Resizing page blob #{containerName}\\#{blobName} with size #{size}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.resize_page_blob(containerName, blobName, size, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Resized page blob #{containerName}\\#{blobName} with size #{size}")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def setSequenceNumber(requestInfo, accountInfo, sequenceNumberAction, sequenceNumber)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        action = XSS::Converter::BlobConverter::convertSequenceNumberAction(sequenceNumberAction)
        # ==== Operation ==== #
        LoggingAspect::info("Setting sequence number for page blob #{containerName}\\#{blobName} with action #{sequenceNumberAction} and sequence number #{sequenceNumber}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.set_sequence_number(containerName, blobName, action, sequenceNumber, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("page blob #{containerName}\\#{blobName}'s sequenceNumber is set")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def writePages(writePagesPayload, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        requestInfo = writePagesPayload.requestInfo
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        options[:transactional_md5] = writePagesPayload.contentMD5 if writePagesPayload.contentMD5
        length = writePagesPayload.pageData.length
        startOffset = writePagesPayload.startOffset
        endOffset = startOffset + length - 1
        # ==== Operation ==== #
        LoggingAspect::info("Putting pages for page blob #{containerName}\\#{blobName} with start offset #{startOffset}, endOffset #{endOffset}")
        LoggingAspect::debug("'pageData' is #{writePagesPayload.pageData}") if length < 100
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.put_blob_pages(containerName, blobName, startOffset, endOffset, writePagesPayload.pageData, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Putting pages for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def clearPages(requestInfo, accountInfo, startOffset, length)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Clearing pages for page blob #{containerName}\\#{blobName} with start offset #{startOffset}, endOffset #{startOffset + length}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.clear_blob_pages(containerName, blobName, startOffset, startOffset + length - 1, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Clearing pages for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def getPageRanges(requestInfo, accountInfo, offset, length)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        options[:start_range] = offset
        options[:end_range] = offset + length - 1
        options[:snapshot] = requestInfo.snapshotTime if requestInfo.snapshotTime
        # ==== Operation ==== #
        LoggingAspect::info("Listing pages for page blob #{containerName}\\#{blobName} with offset #{offset}, endOffset #{options[:end_range]}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.list_page_blob_ranges(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Listing pages for page blob #{containerName}\\#{blobName} successful")
        pageRangesResponse = XSS::AutoGenerated::BlobGetPageRangesResponse.new
        pageRangesResponse.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
        pageRangesResponse.pageRanges = XSS::Converter::BlobConverter::buildPageRangesFromListRangeResult(result)
        pageRangesResponse
      end

      def uploadFromByteArray(requestInfo, accountInfo, buffer, index, count)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Uploading from stream for page blob #{containerName}\\#{blobName} with length #{length}")
        LoggingAspect::debug("'source' is #{source}") if length < 100
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.create_page_blob_from_content(containerName, blobName, count, buffer[index, count], options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Uploading from stream for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def uploadFromStream(requestInfo, accountInfo, source, length)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Uploading from stream for page blob #{containerName}\\#{blobName} with length #{length}")
        LoggingAspect::debug("'source' is #{source}") if length < 100
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.create_page_blob_from_content(containerName, blobName, length, source, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Uploading from stream for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def startIncrementalCopy(requestInfo, accountInfo, uri)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Starting incremental copy for page blob #{containerName}\\#{blobName} with uri #{uri.primaryUri}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.incremental_copy_blob(containerName, blobName, uri.primaryUri, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Incremental copy for page blob #{containerName}\\#{blobName} successful")
        copyResponse = XSS::AutoGenerated::BlobStartCopyFromBlobResponse.new
        copyResponse.copyID = result[0]
        copyResponse.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
        copyResponse
      end
    end
  end
end

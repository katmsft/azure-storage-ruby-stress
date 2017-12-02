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
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Creating page blob #{containerName}\\#{blobName} with size #{size}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.create_page_blob(containerName, blobName, size, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Page blob #{containerName}\\#{blobName} with size #{size} created")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def resize(requestInfo, accountInfo, size)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Resizing page blob #{containerName}\\#{blobName} with size #{size}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.resize_page_blob(containerName, blobName, size, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Resized page blob #{containerName}\\#{blobName} with size #{size}")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def setSequenceNumber(requestInfo, accountInfo, sequenceNumberAction, sequenceNumber)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        action = XSS::Converter::BlobConverter::convertSequenceNumberAction(sequenceNumberAction)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Setting sequence number for page blob #{containerName}\\#{blobName} with action #{sequenceNumberAction} and sequence number #{sequenceNumber}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.set_sequence_number(containerName, blobName, action, sequenceNumber, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("page blob #{containerName}\\#{blobName}'s sequenceNumber is set")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def writePages(writePagesPayload, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
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
        endOffset = startOffset + length
        # ==== Operation ==== #
        LoggingAspect::logger.info("Putting pages for page blob #{containerName}\\#{blobName} with start offset #{startOffset}, endOffset #{endOffset}")
        LoggingAspect::logger.debug("'pageData' is #{writePagesPayload.pageData}") if length < 100
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.put_blob_pages(containerName, blobName, startOffset, endOffset, writePagesPayload.pageData, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Putting pages for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def clearPages(requestInfo, accountInfo, startOffset, length)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Clearing pages for page blob #{containerName}\\#{blobName} with start offset #{startOffset}, endOffset #{startOffset + length}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.clear_blob_pages(containerName, blobName, startOffset, startOffset + length, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Clearing pages for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def getPageRanges(requestInfo, accountInfo, offset, length)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        options[:start_range] = offset
        options[:end_range] = offset + length
        options[:previous_snapshot] = requestInfo.snapshotTime if requestInfo.snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Listing pages for page blob #{containerName}\\#{blobName} with offset #{offset}, endOffset #{startOffset + length}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.list_page_blob_ranges(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Listing pages for page blob #{containerName}\\#{blobName} successful")
        pageRangesResponse = XSS::AutoGenerated::BlobGetPageRangesResponse.new
        pageRangesResponse.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
        pageRangesResponse.pageRanges = XSS::Converter::BlobConverter::buildPageRangesFromListRangeResult(result)
        pageRangesResponse
      end

      def uploadFromStream(requestInfo, accountInfo, source, length)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        startOffset = 0
        endOffset = length - 1
        # ==== Operation ==== #
        LoggingAspect::logger.info("Uploading from stream for page blob #{containerName}\\#{blobName} with start offset #{startOffset}, endOffset #{endOffset}")
        LoggingAspect::logger.debug("'source' is #{source}") if length < 100
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.put_blob_pages(containerName, blobName, startOffset, endOffset, source, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Uploading from stream for page blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def startIncrementalCopy(requestInfo, accountInfo, uri)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Starting incremental copy for page blob #{containerName}\\#{blobName} with uri #{uri.primaryUri}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.incremental_copy_blob(containerName, blobName, uri.primaryUri, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Incremental copy for page blob #{containerName}\\#{blobName} successful")
        copyResponse = XSS::AutoGenerated::BlobStartCopyFromBlobResponse.new
        copyResponse.copyID = result[0]
        copyResponse.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
        copyResponse
      end
    end
  end
end

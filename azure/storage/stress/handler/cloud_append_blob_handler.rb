require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_append_blob_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudAppendBlobHandler < CloudBlobHandler
      def create(requestInfo, accountInfo)
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
        LoggingAspect::info("Creating append blob #{containerName}\\#{blobName}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.create_append_blob(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Creating append blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end

      def appendBlockFromStream(requestInfo, accountInfo, buffer, length)
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
        LoggingAspect::info("Appending block from stream to append blob #{containerName}\\#{blobName}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.append_blob_block(containerName, blobName, buffer[0, length], options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Appending block from stream to append blob #{containerName}\\#{blobName} successful")
        r = XSS::AutoGenerated::AppendBlockFromByteArrayResponse.new
        r.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
        r.bytesRead = result.properties[:append_offset] if result.properties && result.properties[:append_offset]
        r
      end

      def appendBlockFromByteArray(requestPayload, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        requestInfo = requestPayload.requestInfo
        buffer = requestPayload.buffer
        idx = requestPayload.index
        count = requestPayload.count
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        options[:content_md5] = requestPayload.contentMD5 if requestPayload.contentMD5
        # ==== Operation ==== #
        LoggingAspect::info("Appending block from byte array to append blob #{containerName}\\#{blobName}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.append_blob_block(containerName, blobName, buffer[idx, count], options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Appending block from byte array to append blob #{containerName}\\#{blobName} successful")
        r = XSS::AutoGenerated::AppendBlockFromByteArrayResponse.new
        r.response = XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
        r.bytesRead = result.properties[:append_offset] if result.properties && result.properties[:append_offset]
        r
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
        LoggingAspect::info("Creating append blob #{containerName}\\#{blobName}")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = blobClient.create_append_blob_from_content(containerName, blobName, buffer[index, count], options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Creating append blob #{containerName}\\#{blobName} successful")
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(@request_info)
      end
    end
  end
end

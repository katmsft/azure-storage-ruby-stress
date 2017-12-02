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
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        blobName = requestInfo.blobName
        containerName = requestInfo.containerName
        options = XSS::Converter::CoreConverter::getRequestOptions(requestInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # ==== Operation ==== #
        result = blobClient.get_blob_properties(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def appendBlockFromByteArray(requestPayload, accountInfo)
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
        result = blobClient.get_blob_properties(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def appendBlockFromStream(requestInfo, accountInfo, buffer, length)
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
        result = blobClient.get_blob_properties(containerName, blobName, options)
        # ==== Construct Return Value ==== #
        XSS::Converter::BlobConverter::buildCloudBlobResponseFromInternalRequestInfo(internalRequestInfo)
      end
    end
  end
end

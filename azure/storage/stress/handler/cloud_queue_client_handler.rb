require_relative "base_handler"
require_relative "cloud_queue_base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_queue_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/queue_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudQueueClientHandler < CloudQueueBaseHandler
      def listQueues(listQueuesPayload, accountInfo)
        # ==== Construct Return Value ==== #
        result = XSS::AutoGenerated::ListQueuesResponse.new
        result.queueList = entries
        return result

        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::CoreConverter::getRequestOptions(listQueuesPayload.requestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(listQueuesPayload.thriftOperationContext)
        options[:metadata] = true if listQueuesPayload.detailsIncluded == XSS::AutoGenerated::ThriftQueueListingDetails::Metadata
        options[:prefix] = listQueuesPayload.prefix if listQueuesPayload.prefix
        # ==== Operation ==== #
        r = XSS::AutoGenerated::ListQueuesResponse.new
        r.queueList = []
        LoggingAspect::info("Listing queues")
        nextMarker = nil
        # Recursive list
        loop do
          options[:marker] = nextMarker if nextMarker
          LoggingAspect::debug("'options' is #{options.to_s}")
          result = queueClient.list_queues(options)
          # ==== Construct Return Value ==== #
          result.each { |queue| r.queueList.push XSS::Converter::QueueConverter::buildCloudQueueResponseFromQueueAndClient(queue, queueClient) }
          nextMarker = result.continuation_token
          break unless nextMarker && !nextMarker.empty?
        end
        LoggingAspect::info("Listing containers successful")
        r
      end

      def listQueuesSegmented(listQueuesPayload, accountInfo, maxResults, currentToken)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::CoreConverter::getRequestOptions(listQueuesPayload.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(listQueuesPayload.thriftOperationContext)
        options[:metadata] = true if listQueuesPayload.detailsIncluded == XSS::AutoGenerated::ThriftQueueListingDetails::Metadata
        options[:prefix] = listQueuesPayload.prefix if listQueuesPayload.prefix
        options[:max_results] = maxResults if maxResults && maxResults > 0
        options[:marker] = currentToken.nextMarker if currentToken && currentToken.nextMarker
        options[:location_mode] = XSS::Converter::CoreConverter::getLocationModeFromStorageLocation(currentToken.targetLocation) if currentToken && currentToken.targetLocation
        # ==== Operation ==== #
        LoggingAspect::info("Listing queues segmented")
        LoggingAspect::debug("'options' is #{options.to_s}")
        result = queueClient.list_queues(reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Listing queues segmented successful")
        r = XSS::AutoGenerated::ListContainersResponse.new
        r.continuationToken = XSS::Converter::QueueConverter::getQueueContinuationToken(result.continuation_token, @request_info.uri)
        r.queueList = []
        result.each { |queue| r.queueList.push XSS::Converter::QueueConverter::buildCloudQueueResponseFromQueueAndClient(queue, queueClient) }
        r
      end

      def setProperties(thriftRequestOptions, accountInfo, thriftOperationContext, properties)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::CoreConverter.getRequestOptions(thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(thriftOperationContext)
        serviceProperties = XSS::Converter::CoreConverter.convertThriftStorageServicePropertiesToServiceProperties(properties)
        # ==== Operation ==== #
        LoggingAspect::info("Setting service properties")
        LoggingAspect::debug("'options' is #{options.to_s}")
        queueClient.set_service_properties(serviceProperties, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Setting service properties successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(@request_info)
      end

      def getProperties(thriftRequestOptions, thriftOperationContext, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Getting service properties")
        LoggingAspect::debug("'options' is #{reqOptions.to_s}")
        result = queueClient.get_service_properties(reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Getting service properties")
        # ==== Construct Return Value ==== #
        XSS::Converter::CoreConverter.convertServicePropertiesToThriftStorageServiceProperties(result)
      end

      def getServiceStats(thriftRequestOptions, thriftOperationContext, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(@request_info, accountInfo)
        reqOptions = XSS::Converter::CoreConverter::getRequestOptions(thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::info("Getting service status")
        LoggingAspect::debug("'options' is #{reqOptions.to_s}")
        result = queueClient.get_service_stats(reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::info("Getting service status successful")
        XSS::Converter::CoreConverter.convertGetServiceStatsResultToThriftServiceStats(result)
      end
    end
  end
end

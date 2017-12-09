require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_queue_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/queue_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudQueueClientHandler < BaseHandler
      def listQueues(listQueuesPayload, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(internalRequestInfo, accountInfo, XSS::Converter::QueueConverter.getQueueService)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(listQueuesPayload.requestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        reqOptions[:prefix] = listQueuesPayload.prefix unless listQueuesPayload.prefix.nil?
        reqOptions[:metadata] = true if listQueuesPayload.detailsIncluded == XSS::AutoGenerated::ThriftQueueListingDetails::Metadata

        # ==== Operation ==== #
        temp = nil
        entries = []
        begin
          unless temp.nil?
            reqOptions[:marker] = temp.continuation_token
          end
          # XSS::Infrastructure::LoggingAspect.logger.debug reqOptions
          temp = queueClient.list_queues(reqOptions)
          temp.each do |queue|
            entry = XSS::AutoGenerated::CloudQueueResponse.new
            entry.name = queue.name
            entry.metadata = queue.metadata
            # TODO storageURI
            entries.push(entry)
          end
        end while temp.continuation_token != ""

        # ==== Construct Return Value ==== #
        result = XSS::AutoGenerated::ListQueuesResponse.new
        result.queueList = entries
        return result
      end

      def listQueuesSegmented(listQueuesPayload, accountInfo, maxResults, currentToken)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(internalRequestInfo, accountInfo, XSS::Converter::QueueConverter.getQueueService)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(listQueuesPayload.requestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        reqOptions[:prefix] = listQueuesPayload.prefix unless listQueuesPayload.prefix.nil?
        reqOptions[:metadata] = true if listQueuesPayload.detailsIncluded == XSS::AutoGenerated::ThriftQueueListingDetails::Metadata
        reqOptions[:max_results] = maxResults
        reqOptions[:marker] = currentToken.nextMarker
        # XSS::Infrastructure::LoggingAspect.logger.debug reqOptions

        # ==== Operation ==== #
        temp = queueClient.list_queues(reqOptions)

        # ==== Construct Return Value ==== #
        entries = []
        temp.each do |queue|
          entry = XSS::AutoGenerated::CloudQueueResponse.new
          entry.name = queue.name
          entry.metadata = queue.metadata
          # TODO storageURI
          entries.push(entry)
        end
        result = XSS::AutoGenerated::ListQueuesResponse.new
        result.continuationToken.nextMarker = temp.continuation_token
        result.queueList = entries
        return result
      end

      def setProperties(thriftRequestOptions, accountInfo, thriftOperationContext, properties)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(internalRequestInfo, accountInfo, XSS::Converter::QueueConverter.getQueueService)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        serviceProperties = XSS::Converter::CoreConverter.convertThriftStorageServicePropertiesToServiceProperties(properties)

        # ==== Operation ==== #
        queueClient.set_service_properties(serviceProperties, reqOptions)

        # ==== Construct Return Value ==== #
        return
      end
      def getProperties(thriftRequestOptions, thriftOperationContext, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(internalRequestInfo, accountInfo, XSS::Converter::QueueConverter.getQueueService)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        temp = queueClient.get_service_properties(reqOptions)

        # ==== Construct Return Value ==== #
        result = XSS::Converter::CoreConverter.convertServicePropertiesToThriftStorageServiceProperties(temp)
        return result
      end
      def getServiceStats(thriftRequestOptions, thriftOperationContext, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        queueClient = self.build_client(internalRequestInfo, accountInfo, XSS::Converter::QueueConverter.getQueueService)
        # ==== Construct Parameters ==== #
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # where is the interface of this function
        # ==== Operation ==== #
        temp = queueClient.get_service_stats(reqOptions)


        # ==== Construct Return Value ==== #
        result = XSS::Converter::CoreConverter.convertGetServiceStatsResultToThriftServiceStats(temp)
        return result
      end
    end
  end
end

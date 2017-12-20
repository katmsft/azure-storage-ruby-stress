require_relative "base_handler"
require_relative "cloud_table_base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_table_service"
require_relative "../converter/core_converter"
require_relative "../converter/table_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudTableHandler < CloudTableBaseHandler
      def create(createIfNotExists, requestInfo, accountInfo)
        if createIfNotExists
          if self.exists(requestInfo, accountInfo)
            return true
          end
        end
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)

        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Create table: #{tableName}")
        temp = tableClient.create_table(tableName, reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Create table: #{tableName} successful")
        true
      end

      def exists(requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Get table (exists?): #{tableName}")
        exist = false
        exception = nil
        begin
          tableClient.get_table(tableName, reqOptions)
          exist = true
        rescue Azure::Core::Http::HTTPError => e
          raise e if e.status_code != 404 || !e.description.include?(XSS::Constants::ERROR_TABLE_NOT_EXIST)
        end

        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Get table (exists?): #{tableName} successful")
        exist
      end

      def deleteTable(deleteIfExists, requestInfo, accountInfo)
        if deleteIfExists
          if !self.exists(requestInfo, accountInfo)
            return true
          end
        end
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Delete table: #{tableName}")
        LoggingAspect::logger.debug("'options' is #{reqOptions.to_s}")
        temp = tableClient.delete_table(tableName, reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Delete table: #{tableName} successful")
        true
      end

      def setPermissions(requestInfo, accountInfo, permissions)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        reqOptions[:signed_identifiers] = XSS::Converter::CoreConverter.getSignedIdentifiersFromThriftSharedAccessPolicies(permissions.sharedAccessPolicies)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Set table ACL: #{tableName}")
        LoggingAspect::logger.debug("'options' is #{reqOptions.to_s}")
        tableClient.set_table_acl(tableName, reqOptions)

        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Set table ACL: #{tableName} successful")
        nil
      end

      def getPermissions(requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Get table ACL: #{tableName}")
        LoggingAspect::logger.debug("'options' is #{reqOptions.to_s}")
        temp = tableClient.get_table_acl(tableName, reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Get table ACL: #{tableName} successful")
        result = XSS::AutoGenerated::ThriftTablePermissions.new
        result.sharedAccessPolicies = XSS::Converter::CoreConverter::getThriftSharedAccessPoliciesFromSignedIdentifiers(temp, XSS::AutoGenerated::ThriftSharedAccessTablePolicy)
        result
      end

      def Execute(operation, requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        entity = XSS::Converter::TableConverter.getStorageEntityFromThriftOperation(operation)
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        result = XSS::AutoGenerated::ThriftTableResult.new
        LoggingAspect::logger.info("Execute  #{operation.operationType.to_s} on table #{tableName}")
        LoggingAspect::logger.debug("entity is: #{entity.inspect} options is #{reqOptions.to_s}")
        case operation.operationType
        when XSS::AutoGenerated::ThriftTableOperationType::Insert
          temp = tableClient.insert_entity(tableName, entity, reqOptions)
          result.httpStatusCode = 200
          result.etag = temp.etag
        when XSS::AutoGenerated::ThriftTableOperationType::Delete
          temp = tableClient.delete_entity(tableName, entity[:PartitionKey], entity[:RowKey], reqOptions)
          result.httpStatusCode = 200
        when XSS::AutoGenerated::ThriftTableOperationType::Replace
          temp = tableClient.update_entity(tableName, entity, reqOptions)
          result.httpStatusCode = 200
          result.etag = temp
        when XSS::AutoGenerated::ThriftTableOperationType::Merge
          temp = tableClient.merge_entity(tableName, entity, reqOptions)
          result.httpStatusCode = 200
          result.etag = temp
        when XSS::AutoGenerated::ThriftTableOperationType::InsertOrReplace
          temp = tableClient.insert_or_replace_entity(tableName, entity, reqOptions)
          result.httpStatusCode = 200
          result.etag = temp
        when XSS::AutoGenerated::ThriftTableOperationType::InsertOrMerge
          temp = tableClient.insert_or_merge_entity(tableName, entity, reqOptions)
          result.httpStatusCode = 200
          result.etag = temp
        when XSS::AutoGenerated::ThriftTableOperationType::Retrieve
          temp = tableClient.get_entity(tableName, entity[:PartitionKey], entity[:RowKey], reqOptions)
          result.entity = XSS::Converter::TableConverter.getThriftEntityFromStorageEntity(temp)
          result.httpStatusCode = 200
          result.etag = result.entity.etag
        end

        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Execute  #{operation.operationType.to_s} on table #{tableName} successful")
        result
      end

      def ExecuteBatch(operations, requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        batch = XSS::Converter::TableConverter.getStorageBatchFromThriftOperations(tableName, operations)
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)

        # ==== Operation ==== #
        LoggingAspect::logger.info("Execute batch on table #{tableName}")
        LoggingAspect::logger.debug("options is #{reqOptions.to_s}")
        temp = nil
        result = []
        temp = tableClient.execute_batch(batch, reqOptions)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Execute batch on table #{tableName} successful")
        result = []
        temp.each do |response|
          opResult = XSS::AutoGenerated::ThriftTableResult.new
          opResult.etag =
            if response.nil?
              nil
            elsif response.is_a?(Azure::Storage::Table::Entity)
              opResult.entity = response
              response.etag
            else
              response
            end
          opResult.httpStatusCode = 200
          result.push(opResult)
        end
        result
      end

      def ExecuteQuery(tableQuery, requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        query = XSS::Converter::TableConverter.getStorageQueryFromThriftQuery(tableQuery)
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        reqOptions.merge! query

        # ==== Operation ==== #
        LoggingAspect::logger.info("Execute query on table #{tableName}")
        LoggingAspect::logger.debug("options is #{reqOptions.to_s}")
        result = []
        begin
          reqOptions[:continuation_token] = temp.continuation_token if temp
          temp = tableClient.query_entities(tableName, reqOptions)
          unless temp.nil?
            temp.each do |entity|
              thriftEntity = XSS::Converter::TableConverter.getThriftEntityFromStorageEntity(entity)
              result.push(thriftEntity)
            end
          end
        end while !temp.nil? && !temp.continuation_token.nil?

        LoggingAspect::logger.info("Execute query on table #{tableName} successful")
        # ==== Construct Return Value ==== #
        result
      end

      def ExecuteQuerySegment(tableQuery, continuationToken, requestInfo, accountInfo)
        @request_info = XSS::Utilities::get_default_request_info
        tableClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        tableName = requestInfo.tableName
        query = XSS::Converter::TableConverter.getStorageQueryFromThriftQuery(tableQuery, continuationToken)
        reqOptions = XSS::Converter::CoreConverter.getRequestOptions(requestInfo.thriftRequestOptions)
        reqOptions.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        reqOptions.merge! query

        # ==== Operation ==== #
        LoggingAspect::logger.info("Execute query segmented on table #{tableName}")
        LoggingAspect::logger.debug("options is #{reqOptions.to_s}")
        result = XSS::AutoGenerated::TableQueryResultSegment.new
        temp = tableClient.query_entities(tableName, reqOptions)

        # ==== Construct Return Value ==== #
        unless temp.continuation_token.nil?
          result.continuationToken = XSS::AutoGenerated::ThriftTableContinuationToken.new
          result.continuationToken.nextPartitionKey = temp.continuation_token[:next_partition_key]
          result.continuationToken.nextRowKey = temp.continuation_token[:next_row_key]
        end

        LoggingAspect::logger.info("Execute query segmented on table #{tableName} successful")
        result.tableEntities = []
        temp.each do |entity|
          thriftEntity = XSS::Converter::TableConverter.getThriftEntityFromStorageEntity(entity)
          result.tableEntities.push(thriftEntity)
        end
        result
      end
    end
  end
end

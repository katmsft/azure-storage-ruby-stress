require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_share_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudFileShareHandler < CloudFileBaseHandler
      def createShare(accountInfo, shareName, createIfNotExists, snapshotTime, fileRequestOptions, operationContext)
        # If share already exists, return response from self.exists
        if createIfNotExists
          exists = self.exists(accountInfo, shareName, snapshotTime, fileRequestOptions, operationContext)
          if (exists.exists)
            r = XSS::AutoGenerated::CreateFileShareResponse.new
            r.wasCreated = false
            r.cloudFileShareResponse = exists.cloudFileShareResponse
            return r
          end
        end
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: snapshotTime?
        # TODO: options[:quota] =
        # TODO: options[:metadata] =
        # ==== Operation ==== #
        created = true
        begin
          LoggingAspect::logger.info("Creating share #{shareName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.create_share(shareName, options)
        rescue Azure::Core::Http::HTTPError => e
          LoggingAspect::logger.info("Failed to create share #{shareName}")
          created = false
        end
        # ==== Construct Return Value ==== #
        r = XSS::AutoGenerated::CreateFileShareResponse.new
        r.wasCreated = created
        r.cloudFileShareResponse = XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info)
        LoggingAspect::logger.info("Created share #{shareName} Successful") if created
        r
      end

      def deleteShare(accountInfo, shareName, deleteIfExists, snapshotTime, deleteSnapshotOptions, accessCondition, fileRequestOptions, operationContext)
        # If share does not exist, return success
        if deleteIfExists
          exists = self.exists(accountInfo, shareName, snapshotTime, fileRequestOptions, operationContext)
          unless (exists.exists)
            return true
          end
        end
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # TODO: deleteSnapshotOptions
        # ==== Operation ==== #
        begin
          LoggingAspect::logger.info("Deleting share #{shareName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.delete_share(shareName, options)
        rescue Azure::Core::Http::HTTPError => e
          raise e
        end
        # ==== Construct Return Value ==== #
        # return true at this point since no exception is raised for deletion
        LoggingAspect::logger.info("Deleted share #{shareName} Successful")
        true
      end

      def fetchAttributes(accountInfo, shareName, snapshotTime, accessCondition, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Fetching share attributes #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.get_share_properties(shareName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Fetching share #{shareName} attributes successful")
        XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info)
      end

      def exists(accountInfo, shareName, snapshotTime, fileRequestOptions, operationContext)
        exists = true
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: snapshotTime
        # ==== Operation ==== #
        begin
          LoggingAspect::logger.info("Fetching share attributes #{shareName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.get_share_properties(shareName, options)
        rescue Azure::Core::Http::HTTPError => e
          if e.description.include? XSS::Constants::ERROR_SHARE_NOT_EXIST
            LoggingAspect::logger.info("share #{shareName} does not exist")
            exists = false
          else
            raise e
          end
        end
        # ==== Construct Return Value ==== #
        r = XSS::AutoGenerated::ExistsFileShareResponse.new
        r.exists = exists
        r.cloudFileShareResponse = XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info) if exists
        LoggingAspect::logger.info("share #{shareName} exists") if exists
        r
      end

      def setMetadata(accountInfo, shareName, metadata, snapshotTime, accessCondition, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Setting metadata for share #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        LoggingAspect::logger.debug("'metadata' is #{metadata.to_s}")
        result = fileClient.set_share_metadata(shareName, metadata, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Setting metadata for share #{shareName} successful")
        r = XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info)
        r.metadata = metadata
        r
      end

      def setProperties(requestInfo, accountInfo, properties)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = requestInfo.shareName
        snapshotTime = requestInfo.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(requestInfo.fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(requestInfo.thriftOperationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(requestInfo.accessCondition)
        options[:quota] = properties.shareQuota if properties.shareQuota
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Setting properties for share #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.set_share_properties(shareName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Setting properties for share #{shareName} successful")
        XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info)
      end

      def setPermissions(reqInfo, accountInfo, permissions)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = reqInfo.shareName
        snapshotTime = reqInfo.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(reqInfo.fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.accessCondition)
        # TODO: snapshotTime
        options[:signed_identifiers] = XSS::Converter::CoreConverter::getSignedIdentifiersFromThriftSharedAccessPolicies(permissions.sharedAccessPolicies)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Setting ACLs for share #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.set_share_acl(shareName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Setting ACLs for share #{shareName} successful")
        XSS::Converter::FileConverter::buildCloudFileShareResponseFromInternalRequestInfo(@request_info)
      end

      def getPermissions(reqInfo, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = reqInfo.shareName
        snapshotTime = reqInfo.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(reqInfo.fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Getting ACLs for share #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.get_share_acl(shareName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Getting ACLs for share #{shareName} successful")
        r = XSS::AutoGenerated::ThriftFileSharePermissions.new
        r.sharedAccessPolicies = XSS::Converter::CoreConverter::getThriftSharedAccessPoliciesFromSignedIdentifiers(result[1], XSS::AutoGenerated::ThriftSharedAccessBlobPolicy)
        r
      end

      def getShareStats(shareName, snapshotTime, fileRequestOptions, thriftOperationContext, accountInfo)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(thriftOperationContext)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Getting Stat for share #{shareName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.get_share_stats(shareName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Getting Stat for share #{shareName} successful")
        r = XSS::AutoGenerated::ThriftFileShareStats.new
        r.usage = result.usage
        r
      end
    end
  end
end

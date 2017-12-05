require_relative "base_handler"
require_relative "cloud_blob_base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_blob_container_service"
require_relative "../converter/core_converter"
require_relative "../converter/blob_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudBlobContainerHandler < CloudBlobBaseHandler
      def exists(reqInfo, accountInfo)
        exists = true
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # ==== Operation ==== #
        begin
          LoggingAspect::logger.info("Fetching container attributes #{containerName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = blobClient.get_container_properties(containerName, options)
        rescue Azure::Core::Http::HTTPError => e
          if e.description.include? XSS::Constants::ERROR_CONTAINER_NOT_EXIST
            LoggingAspect::logger.info("Container #{containerName} does not exist")
            exists = false
          else
            raise exists
          end
        end
        # ==== Construct Return Value ==== #
        result = XSS::AutoGenerated::BlobContainerExistsResponse.new
        result.exists = exists
        result.response = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo) if exists
        LoggingAspect::logger.info("Container #{containerName} exists") if exists
        result
      end

      def fetchAttributes(reqInfo, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Fetching container attributes #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.get_container_properties(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Fetching container #{containerName} attributes successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def setMetadata(reqInfo, accountInfo, metadata)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Fetching container attributes #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.set_container_metadata(containerName, metadata, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Fetching container #{containerName} attributes successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def createContainer(reqInfo, accountInfo, accessType, createIfNotExists, metadata)
        # If container already exists, return response from self.exists
        if createIfNotExists
          exists = self.exists(reqInfo, accountInfo)
          if (exists.exists)
            return exists.response
          end
        end
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        options[:metadata] = metadata unless metadata.nil?
        accessType = XSS::Converter::BlobConverter::getAccessTypeFromBlobContainerPublicAccessType(accessType)
        options[:public_access_level] = accessType unless accessType.nil?
        # ==== Operation ==== #
        created = true
        begin
          LoggingAspect::logger.info("Creating container #{containerName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = blobClient.create_container(containerName, options)
        rescue Azure::Core::Http::HTTPError => e
          LoggingAspect::logger.info("Failed to create container #{containerName}")
          created = false
        end
        # ==== Construct Return Value ==== #
        result = XSS::AutoGenerated::CreateContainerResponse.new
        result.containerCreated = created
        result.containerResponse = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
        LoggingAspect::logger.info("Created container #{containerName}") if created
        result
      end

      def deleteContainer(reqInfo, accountInfo, deleteIfExists)
        # If container does not exist, return success
        if deleteIfExists
          exists = self.exists(reqInfo, accountInfo)
          unless (exists.exists)
            return true
          end
        end
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # ==== Operation ==== #
        begin
          LoggingAspect::logger.info("Deleting container #{containerName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          blobClient.delete_container(containerName, options)
        rescue Azure::Core::Http::HTTPError => e
          raise e
        end
        # ==== Construct Return Value ==== #
        # return true at this point since no exception is raised for deletion
        LoggingAspect::logger.info("Deleted container #{containerName}")
        true
      end

      def listBlobsSegmented(listBlobsPayload, accountInfo, maxResults, continuationToken, containerName)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        reqInfo = listBlobsPayload.thriftRequestOptions
        options = XSS::Converter::BlobConverter::getRequestOptions(listBlobsPayload.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(listBlobsPayload.thriftOperationContext)
        options[:prefix] = listBlobsPayload.prefix if listBlobsPayload.prefix
        options[:max_results] = maxResults
        options[:marker] = continuationToken.nextMarker
        options[:location_mode] = XSS::Converter::CoreConverter::getLocationModeFromStorageLocation(continuationToken.targetLocation)
        options.merge! XSS::Converter::BlobConverter::getListDetailOptionsFromThriftBlobListingDetails(listBlobsPayload.listingDetails)
        # options[:delimiter]?
        # TODO: useFlatBlobListing, listingDetails
        # ==== Operation ==== #
        LoggingAspect::logger.info("Listing blob segmented for container #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.list_blobs(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Listing blob segmented for container #{containerName} successful")
        r = XSS::AutoGenerated::ListBlobsResponse.new
        r.continuationToken = XSS::Converter::BlobConverter::getBlobContinuationToken(result.continuation_token, internalRequestInfo.uri)
        r.blobList = []
        result.each { |blob| r.blobList.push XSS::Converter::BlobConverter::buildListBlobItemWithBlobContainerAndClient(blob, containerName, blobclient) }
        r
      end

      def acquireLease(reqInfo, accountInfo, leaseTime, proposedLeaseId)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        options[:duration] = leaseTime
        options[:proposed_lease_id] = proposedLeaseId
        # ==== Operation ==== #
        LoggingAspect::logger.info("Acquiring lease for container #{containerName} with leaseTime #{leaseTime}, proposedLeaseId #{proposedLeaseId}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.acquire_lease(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Acquiring lease for container #{containerName} successful")
        r = XSS::AutoGenerated::ContainerChangeAcquireLeaseResponse.new
        r.leaseId = result
        r.response = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
        r
      end

      def changeLease(reqInfo, accountInfo, proposedLeaseId)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        lease = options[:lease_id]
        # ==== Operation ==== #
        LoggingAspect::logger.info("Changing lease for container #{containerName} with proposedLeaseId #{proposedLeaseId}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.change_container_lease(containerName, lease, proposedLeaseId, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Changing lease for container #{containerName} successful")
        r = XSS::AutoGenerated::ContainerChangeAcquireLeaseResponse.new
        r.leaseId = result
        r.response = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
        r
      end

      def breakLease(reqInfo, accountInfo, breakPeriod)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        options[:break_period] = breakPeriod
        # ==== Operation ==== #
        LoggingAspect::logger.info("Breaking lease for container #{containerName} with breakPeriod #{breakPeriod}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.break_container_lease(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Breaking lease for container #{containerName} successful")
        r = XSS::AutoGenerated::ContainerBreakLeaseResponse.new
        r.remainingLeaseTimeinSeconds = result
        r.response = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
        r
      end

      def renewLease(reqInfo, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        lease = options[:lease_id]
        # ==== Operation ==== #
        LoggingAspect::logger.info("Renewing lease for container #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.renew_container_lease(containerName, lease, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Renewing lease for container #{containerName} successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def releaseLease(reqInfo, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        lease = options[:lease_id]
        # ==== Operation ==== #
        LoggingAspect::logger.info("Releasing lease for container #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.release_container_lease(containerName, lease, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Releasing lease for container #{containerName} successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def setPermissions(reqInfo, accountInfo, permissions)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        publicAccessLevel = XSS::Converter::BlobConverter::getAccessTypeFromBlobContainerPublicAccessType(permissions.containerAccessType)
        options[:signed_identifiers] = XSS::Converter::CoreConverter::getSignedIdentifiersFromThriftSharedAccessPolicies(permission.sharedAccessPolicies)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Setting ACLs for container #{containerName} with public access level #{publicAccessLevel}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.set_container_acl(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Setting ACLs for container #{containerName} successful")
        XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
      end

      def getPermissions(reqInfo, accountInfo)
        # ==== Build Client ==== #
        internalRequestInfo = XSS::Utilities::get_default_request_info
        blobClient = self.build_client(internalRequestInfo, accountInfo)
        # ==== Construct Parameters ==== #
        containerName = reqInfo.containerName
        options = XSS::Converter::BlobConverter::getRequestOptions(reqInfo.thriftRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(reqInfo.thriftAccessCondition)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(reqInfo.thriftOperationContext)
        # ==== Operation ==== #
        LoggingAspect::logger.info("Getting ACLs for container #{containerName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = blobClient.get_container_acl(containerName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Getting ACLs for container #{containerName} successful")
        r = XSS::AutoGenerated::ContainerGetPermissionsResponse.new
        r.response = XSS::Converter::BlobConverter::buildBlobContainerResponseFromInternalRequestInfo(internalRequestInfo)
        r.permissions = XSS::AutoGenerated::ThriftBlobContainerPermissions.new
        r.permissions.containerAccessType = result[0].public_access_level
        r.permissions.sharedAccessPolicies = XSS::Converter::CoreConverter::getThriftSharedAccessPoliciesFromSignedIdentifiers(result[1], XSS::AutoGenerated::ThriftSharedAccessBlobPolicy)
        r
      end
    end
  end
end

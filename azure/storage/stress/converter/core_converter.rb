require "azure/storage"
require_relative "../infrastructure/logging_aspect"
require_relative "../utils"

module Azure::Storage::Stress
  module Converter
    class CoreConverter
      def self.getStorageService(handler, accountInfo)
        # TODO: Support other client and secondary
        # TODO: Support SAS
        XSS::Infrastructure::LoggingAspect.logger.debug(storage_account_name: accountInfo.accountName, storage_access_key: accountInfo.base64EncodedKey)
        # TODO: Need to set endpoint to SCTE end point
        client = Azure::Storage::Client.create(storage_account_name: accountInfo.accountName, storage_access_key: accountInfo.base64EncodedKey)
      end

      def self.getRequestOptions(thriftRequestOptions)
        options = {}
        unless thriftRequestOptions.nil?
          options[:timeout] = thriftRequestOptions.maximumExecutionTimeSeconds unless thriftRequestOptions.maximumExecutionTimeSeconds.nil?
          options[:location_mode] = self.getLocationModeFromThriftLocationMode(thriftRequestOptions.LocationMode)
          # TODO: Map the all the possible options
        end
        options
      end

      def self.getAccessConditionOptions(thriftAccessCondition, prefix = "")
        options = {}
        unless thriftAccessCondition.nil?
          options[:lease_id] = thriftAccessCondition.leaseId unless thriftAccessCondition.leaseId.nil?
          options[(prefix + :if_match.to_s).to_sym] = thriftAccessCondition.ifMatchEtag unless thriftAccessCondition.ifMatchEtag.nil?
          options[(prefix + :if_none_match.to_s).to_sym] = thriftAccessCondition.ifNoneMatchEtag unless thriftAccessCondition.ifNoneMatchEtag.nil?
          options[(prefix + :if_modified_since.to_s).to_sym] = thriftAccessCondition.ifModifiedSinceTime unless thriftAccessCondition.ifModifiedSinceTime.nil?
          options[(prefix + :if_unmodified_since.to_s).to_sym] = thriftAccessCondition.ifNotModifiedSinceTime unless thriftAccessCondition.ifNotModifiedSinceTime.nil?
          options[:if_sequence_number_eq] = thriftAccessCondition.ifSequenceNumberEqual unless thriftAccessCondition.ifSequenceNumberEqual.nil?
          options[:if_sequence_number_lt] = thriftAccessCondition.ifSequenceNumberLessThan unless thriftAccessCondition.ifSequenceNumberLessThan.nil?
          options[:if_sequence_number_le] = thriftAccessCondition.ifSequenceNumberLessThanOrEqual unless thriftAccessCondition.ifSequenceNumberLessThanOrEqual.nil?
        end
        options
      end

      def self.convertThriftStorageServicePropertiesToServiceProperties(properties)
        storageProperties = Azure::Storage::Service::StorageServiceProperties.new
        storageProperties.cors = self.convertCorsRuleArrayToCORSArray(properties.corsRules)
        storageProperties.default_service_version = properties.defaultServiceVersion
        storageProperties.hour_metrics = self.convertMetricsPropertiesToMetrics(properties.hourMetrics)
        storageProperties.logging = self.convertLoggingPropertiesToLogging(properties.logging)
        storageProperties.minute_metrics = self.convertMetricsPropertiesToMetrics(properties.minuteMetrics)
        return storageProperties
      end

      def self.convertServicePropertiesToThriftStorageServiceProperties(properties)
        thriftStorageServiceProperties = XSS::AutoGenerated::ThriftStorageServiceProperties.new
        thriftStorageServiceProperties.corsRules = self.convertCORSArrayToCorsRuleArray(properties.cors)
        thriftStorageServiceProperties.defaultServiceVersion = properties.default_service_version
        thriftStorageServiceProperties.logging = self.convertLoggingToLoggingProperties(properties.logging)
        thriftStorageServiceProperties.minuteMetrics = self.convertMetricsToMetricsProperties(properties.minute_metrics)
        thriftStorageServiceProperties.hourMetrics = self.convertMetricsToMetricsProperties(properties.hour_metrics)
        thriftStorageServiceProperties.deleteRetentionProperties = self.convertDeleteRententionPolicyToDeleteRententionPolicyProperties()
        thriftStorageServiceProperties
      end

      def self.convertCorsRuleArrayToCORSArray(corsRules)
        corss = Azure::Storage::Service::Cors.new
        return corss if corsRules.nil?
        corsRules.each do |corsRule|
          cors = Azure::Storage::Service::CorsRule.new
          cors.allowed_headers = corsRule.allowedHeaders
          cors.allowed_methods = self.filterHTTPMethodsArray(corsRule.allowedMethods)
          cors.allowed_origins = corsRule.allowedOrigins
          cors.exposed_headers = corsRule.exposedHeaders
          cors.max_age_in_seconds = corsRule.maxAgeInSeconds
          corss.cors_rules.push(cors)
        end
        return corss
      end

      def self.convertCORSArrayToCorsRuleArray(corss)
        # return nil if corss.nil?
        # corss cannot be nil, but whether the corsRules can be empty array or not? need to test
        corsRules = []
        corss.cors_rules.each do |cors|
          corsRule = XSS::AutoGenerated::CorsRule.new
          corsRule.maxAgeInSeconds = cors.max_age_in_seconds
          corsRule.allowedHeaders = cors.allowed_headers
          corsRule.allowedMethods = cors.allowed_methods.join(",")
          corsRule.allowedOrigins = cors.allowed_origins
          corsRule.exposedHeaders = cors.exposed_headers
          corsRules.push(corsRule)
        end
        return corsRules
      end

      def self.filterHTTPMethodsArray(methods)
        result = []
        methods.split(",").each do |method|
          if XSS::Constants::HTTP_METHODS.include?(method.capitalize)
            result.push(method.capitalize)
          end
        end
        return result
      end

      def self.convertMetricsPropertiesToMetrics(thriftMetrics)
        metrics = Azure::Storage::Service::Metrics.new
        return metrics if thriftMetrics.nil?
        metrics.enabled = (thriftMetrics.metricsLevel != XSS::AutoGenerated::MetricsLevel::None)
        metrics.include_apis = (thriftMetrics.metricsLevel == XSS::AutoGenerated::MetricsLevel::ServiceAndApi)
        metrics.version = thriftMetrics.version
        # metrics.retention_policy = XSS::Service::RetentionPolicy.new
        metrics.retention_policy.days = thriftMetrics.retentionDays
        metrics.retention_policy.enabled = (thriftMetrics.retentionDays > 0)
      end

      def self.convertMetricsToMetricsProperties(metrics)
        return nil if metrics.nil?
        thriftMetrics = XSS::AutoGenerated::MetricsProperties.new
        thriftMetrics.metricsLevel = metrics.enable ? (metrics.include_apis ? XSS::AutoGenerated::MetricsLevel::ServiceAndApi : XSS::AutoGenerated::MetricsLevel::Service) : XSS::AutoGenerated::MetricsLevel::None
        thriftMetrics.version = metrics.version
        thriftMetrics.retentionDays = metrics.retention_policy.enable ? metrics.retention_policy.days : nil
        return thriftMetrics
      end

      def self.convertLoggingPropertiesToLogging(loggingProperties)
        logging = Azure::Storage::Service::Logging.new
        return logging if loggingProperties.nil?
        logging.version = loggingProperties.version
        # logging.retention_policy = XSS::Service::RetentionPolicy.new
        logging.retention_policy.days = loggingProperties.retentionDays
        logging.retention_policy.enabled = (loggingProperties.retentionDays > 0)
        logging.delete = loggingProperties.loggingOperations.include?(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Delete])
        logging.read = loggingProperties.loggingOperations.include?(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Read])
        logging.write = loggingProperties.loggingOperations.include?(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Write])
        return logging
      end

      def self.convertLoggingToLoggingProperties(logging)
        return nil if logging.nil?
        loggingProperties = XSS::AutoGenerated::LoggingProperties.new
        loggingProperties.version = logging.version
        loggingProperties.retentionDays = logging.retention_policy.enable ? logging.retention_policy.days : nil
        operations = []
        if logging.delete
          operations.push(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Delete])
        end
        if logging.read
          operations.push(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Read])
        end
        if logging.write
          operations.push(XSS::AutoGenerated::LoggingOperations::VALUE_MAP[XSS::AutoGenerated::LoggingOperations::Write])
        end
        loggingProperties.loggingOperations = operations.join(",")
        return loggingProperties
      end

      def self.convertDeleteRententionPolicyToDeleteRententionPolicyProperties()
        return nil
        # see PHP stress proxy - TODO: To be supported in Soft-Delete feature
      end

      def self.convertGetServiceStatsResultToThriftServiceStats(serviceStats)
        thriftServiceStats = XSS::AutoGenerated::ThriftServiceStats.new
        thriftServiceStats.geoReplication = XSS::AutoGenerated::GeoReplicationStats.new
        thriftServiceStats.geoReplication.status = serviceStats.geo_replication.status
        thriftServiceStats.geoReplication.lastSyncTime = serviceStats.geo_replication.last_sync_time
        thriftServiceStats
      end

      def self.getCopyStateFromInternalRequestInfo(rInfo)
        return nil if rInfo.responseHeaders["x-ms-copy-id"].nil? || rInfo.responseHeaders["x-ms-copy-id"].empty?
        copyState = XSS::AutoGenerated::ThriftCopyState.new
        copyState.copyID = rInfo.responseHeaders["x-ms-copy-id"]
        # TODO: assign bytesCopied and totalByte when available.
        copyState.completionTime = XSS::Utilities::timeStringToInteger(rInfo.responseHeaders["x-ms-copy-completion-time"]) unless rInfo.responseHeaders["x-ms-copy-completion-time"].nil?
        # TODO: assign URI when available
        copyState.copyStatus = XSS::Utilities::thriftizeString(XSS::AutoGenerated::ThriftCopyStatus, rInfo.responseHeaders["x-ms-copy-status"]) unless rInfo.responseHeaders["x-ms-copy-status"].nil?
        copyState.statusDescription = rInfo.responseHeaders["x-ms-copy-status-description"] unless rInfo.responseHeaders["x-ms-copy-status-description"].nil?
        copyState.copyDestinationSnapshotID = rInfo.responseHeaders["x-ms-copy-destination-snapshot"] unless rInfo.responseHeaders["x-ms-copy-destination-snapshot"].nil?
        copyState
      end

      def self.getOperationContextOptions(operationContext)
        options = {}
        unless operationContext.nil? || operationContext.userHeaders.nil?
          # TODO: Map the all the possible operation context's header with options
          options[:request_id] = thriftOperationContext.clientRequestId unless thriftOperationContext.nil?
          headers = operationContext.userHeaders
          options[:sequence_number_action] = headers["x-ms-sequence-number-action"] if headers["x-ms-sequence-number-action"]
          options[:sequence_number] = headers["x-ms-sequence-number"] if headers["x-ms-sequence-number"]
        end
        options
      end

      def self.getSignedIdentifiersFromThriftSharedAccessPolicies(sharedAccessPolicies)
        results = []
        sharedAccessPolicies.each { |id, sharedAccessPolicy|
          signedIdentifier = Azure::Storage::Service::SignedIdentifier.new
          accessPolicy = Azure::Storage::Service::AccessPolicy.new
          accessPolicy.permissions = sharedAccessPolicy.permissions
          accessPolicy.expiry = XSS::Utilities::timeIntegerToEdmString sharedAccessPolicy.expiryTime
          accessPolicy.start = XSS::Utilities::timeIntegerToEdmString sharedAccessPolicy.startTime
          signedIdentifier.access_policy = accessPolicy
          signedIdentifier.id = id
          results.push signedIdentifier
        }
        results
      end

      def self.getThriftSharedAccessPoliciesFromSignedIdentifiers(signedIdentifiers, policyClass)
        results = {}
        signedIdentifiers.each { |signedIdentifier|
          # tsp = ThriftSharedAccessPolicy
          tsp = policyClass.new
          accessPolicy = signedIdentifier.access_policy
          tsp.permissions = accessPolicy.permissions
          tsp.expiry = XSS::Utilities::timeStringToInteger accessPolicy.expiryTime
          tsp.start = XSS::Utilities::timeStringToInteger accessPolicy.startTime
          results[signedIdentifier.id] = tsp
        }
        results
      end

      def self.getLocationModeFromThriftLocationMode(locationMode)
        case locationMode
        when XSS::AutoGenerated::LocationMode::PrimaryOnly
          Azure::Storage::LocationMode::PrimaryOnly
        when XSS::AutoGenerated::LocationMode::PrimaryThenSecondary
          Azure::Storage::LocationMode::PrimaryThenSecondary
        when XSS::AutoGenerated::LocationMode::SecondaryOnly
          Azure::Storage::LocationMode::SecondaryOnly
        when XSS::AutoGenerated::LocationMode::SecondaryThenPrimary
          Azure::Storage::LocationMode::SecondaryThenPrimary
        else
          nil
        end
      end

      def self.getLocationModeFromStorageLocation(storageLocation)
        case storageLocation
        when XSS::AutoGenerated::StorageLocation::Primary
          Azure::Storage::LocationMode::PrimaryOnly
        when XSS::AutoGenerated::StorageLocation::Secondary
          Azure::Storage::LocationMode::SecondaryOnly
        else
          nil
        end
      end

      def self.getCloudStorageUriWithClientAndPath(client, path)
        result = XSS::AutoGenerated::CloudStorageUri.new
        result.primaryUri = client.generate_uri(path, {}, { encode: true, location_mode: Azure::Storage::LocationMode::PRIMARY_ONLY })
        result.secondaryUri = client.generate_uri(path, {}, { encode: true, location_mode: Azure::Storage::LocationMode::SECONDARY_ONLY })
        result
      end
    end
  end
end

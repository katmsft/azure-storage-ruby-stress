require "azure/storage"
require_relative "../infrastructure/logging_aspect"

module Azure
  module Storage
    module Converter
      class CoreConverter
        def CoreConverter.getStorageService(handler, accountInfo)
          # TODO: Support other client and secondary
          # TODO: Support SAS
          Azure::Storage::Infrastructure::LoggingAspect.logger.debug(storage_account_name: accountInfo.accountName, storage_access_key: accountInfo.base64EncodedKey)
          return Azure::Storage::Client.create(storage_account_name: accountInfo.accountName, storage_access_key: accountInfo.base64EncodedKey)
        end

        def CoreConverter.getCommonRequestOptions(thriftRequestOptions, thriftOperationContext)
          options = {}
          unless thriftRequestOptions.nil?
            options[:timeout] = thriftRequestOptions.maximumExecutionTimeSeconds unless thriftRequestOptions.maximumExecutionTimeSeconds.nil?
            # serverTimeoutSeconds no idea how to use
          end

          unless thriftOperationContext.nil?
            options[:request_id] = thriftOperationContext.clientRequestId unless thriftOperationContext.nil?
          end
          return options
        end

        def CoreConverter.convertThriftStorageServicePropertiesToServiceProperties(properties)
          storageProperties = Azure::Storage::Service::StorageServiceProperties.new
          storageProperties.cors
          storageProperties.default_service_version
          storageProperties.hour_metrics
          storageProperties.logging
          storageProperties.minute_metrics

          return storageProperties
        end
      end
    end
  end
end

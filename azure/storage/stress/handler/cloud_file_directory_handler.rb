require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_file_directory_service"
require_relative "../converter/core_converter"
require_relative "../converter/file_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Handler
    class CloudFileDirectoryHandler < CloudFileBaseHandler
      def createDirectory(accountInfo, filePath, createIfNotExists, fileRequestOptions, operationContext)
        # If container already exists, return response from self.exists
        # TODO: The return type is not align with the original one. Will this also OK?
        if createIfNotExists
          exists = self.exists(accountInfo, filePath, fileRequestOptions, operationContext)
          if (exists.exists)
            r = XSS::AutoGenerated::CreateFileDirectoryResponse.new
            r.wasCreated = false
            r.cloudFileDirectoryResponse = exists.cloudFileDirectoryResponse
            return r
          end
        end
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: snapshotTime
        # ==== Operation ==== #
        created = true
        begin
          LoggingAspect::logger.info("Create Directory #{shareName}/#{directoryName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.create_directory(shareName, directoryName, options)
        rescue Azure::Core::Http::HTTPError => e
          LoggingAspect::logger.info("Failed to Create Directory #{shareName}/#{directoryName}")
          created = false
        end
        # ==== Construct Return Value ==== #
        r = XSS::AutoGenerated::CreateFileDirectoryResponse.new
        r.wasCreated = created
        r.cloudFileDirectoryResponse = XSS::Converter::FileConverter::bulidCloudFileDirectoryResponseFromInternalRequestInfo(@request_info)
        LoggingAspect::logger.info("Create Directory #{shareName}/#{directoryName} Successful") if created
        r
      end

      def deleteDirectory(accountInfo, filePath, deleteIfExists, accessCondition, fileRequestOptions, operationContext)
        # If container does not exist, return success
        if deleteIfExists
          exists = self.exists(accountInfo, filePath, fileRequestOptions, operationContext)
          unless (exists.exists)
            return true
          end
        end
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        # TODO: Is this rescue useful?
        begin
          LoggingAspect::logger.info("Deleting Directory #{shareName}/#{directoryName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.delete_directory(shareName, directoryName, options)
        rescue Azure::Core::Http::HTTPError => e
          LoggingAspect::logger.info("Failed to Delete Directory #{shareName}/#{directoryName}")
          raise e
        end
        # ==== Construct Return Value ==== #
        # return true at this point since no exception is raised for deletion
        LoggingAspect::logger.info("Deleted Directory #{shareName}/#{directoryName} Successful")
        true
      end

      def setMetadata(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext, metadata)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Set Metadata #{shareName}/#{directoryName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        fileClient.set_directory_metadata(shareName, directoryName, metadata, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Set Metadata #{shareName}/#{directoryName} Successful")
        XSS::Converter::FileConverter::bulidCloudFileDirectoryResponseFromInternalRequestInfo(@request_info)
      end

      def fetchAttributes(accountInfo, filePath, accessCondition, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: No supporting option in the SDK! Maybe this should be deleted?
        options.merge! XSS::Converter::CoreConverter::getAccessConditionOptions(accessCondition)
        # TODO: snapshotTime
        # ==== Operation ==== #
        LoggingAspect::logger.info("Fetching container attributes #{shareName}/#{directoryName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.get_directory_properties(shareName, directoryName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("Fetching container attributes #{shareName}/#{directoryName} Successful")
        XSS::Converter::FileConverter::bulidCloudFileDirectoryResponseFromInternalRequestInfo(@request_info)
      end

      def exists(accountInfo, filePath, fileRequestOptions, operationContext)
        exists = true
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: snapshotTime
        # ==== Operation ==== #
        begin
          LoggingAspect::logger.info("Fetching directory attributes #{shareName}/#{directoryName}")
          LoggingAspect::logger.debug("'options' is #{options.to_s}")
          result = fileClient.get_directory_properties(shareName, directoryName, options)
        rescue Azure::Core::Http::HTTPError => e
          if e.description.include? XSS::Constants::ERROR_DIRECTORY_NOT_EXIST
            LoggingAspect::logger.info("Directory #{shareName}/#{directoryName} does not exist")
            exists = false
          else
            raise e
          end
        end
        # ==== Construct Return Value ==== #
        result = XSS::AutoGenerated::ExistsFileDirectoryResponse.new
        result.exists = exists
        result.cloudFileDirectoryResponse = XSS::Converter::FileConverter::bulidCloudFileDirectoryResponseFromInternalRequestInfo(@request_info) if exists
        LoggingAspect::logger.info("Directory #{shareName}/#{directoryName} exists") if exists
        result
      end

      def listFilesAndDirectoriesSegmented(accountInfo, prefix, filePath, maxResults, continuationToken, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        fileName = filePath.fileName
        snapshotTime = filePath.snapshotTime
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        # TODO: snapshotTime
        options[:prefix] = prefix
        options[:marker] = continuationToken.nextMarker if continuationToken
        options[:max_results] = maxResults
        # ==== Operation ==== #
        LoggingAspect::logger.info("List Files And Directories Segmented #{shareName}/#{directoryName}")
        LoggingAspect::logger.debug("'options' is #{options.to_s}")
        result = fileClient.list_directories_and_files(shareName, directoryName, options)
        # ==== Construct Return Value ==== #
        LoggingAspect::logger.info("List Files And Directories Segmented #{shareName}/#{directoryName} Successful")
        r = XSS::AutoGenerated::ListFileDirResponse.new
        r.continuationToken = XSS::Converter::FileConverter::getFileContinuationToken(result.continuation_token, @request_info.uri)
        r.directories = []
        r.files = []
        result.each do |filesOrdirectories|
          case filesOrdirectories.class.to_s
          when "Azure::Storage::File::Directory::Directory"
            r.directories.push(XSS::Converter::FileConverter::buildCloudFileDirectoryListItemWithDirectory(filesOrdirectories, filePath, fileClient))
          when "Azure::Storage::File::File"
            r.files.push(XSS::Converter::FileConverter::buildCloudFileListItemWithFile(filesOrdirectories, filePath, fileClient))
          end
        end
        r
      end

      def listFilesAndDirectories(accountInfo, prefix, filePath, fileRequestOptions, operationContext)
        # ==== Build Client ==== #
        @request_info = XSS::Utilities::get_default_request_info
        fileClient = self.build_client(@request_info, accountInfo)
        # ==== Construct Parameters ==== #
        shareName = filePath.shareName
        directoryName = filePath.directoryName
        options = XSS::Converter::FileConverter::getRequestOptions(fileRequestOptions)
        options.merge! XSS::Converter::CoreConverter::getOperationContextOptions(operationContext)
        options[:prefix] = prefix
        # ==== Operation ==== #
        r = XSS::AutoGenerated::ListFileDirResponse.new
        r.directories = []
        r.files = []
        LoggingAspect::logger.info("List Files And Directories #{shareName}/#{directoryName}")
        nextMarker = nil
        # Recursive list
        loop do
          options[:marker] = nextMarker if nextMarker
          LoggingAspect::debug("'options' is #{options.to_s}")
          result = fileClient.list_directories_and_files(shareName, directoryName, options)
          # ==== Construct Return Value ==== #
          result.each do |filesOrdirectories|
            case filesOrdirectories.class.to_s
            when "Azure::Storage::File::Directory::Directory"
              r.directories.push(XSS::Converter::FileConverter::buildCloudFileDirectoryListItemWithDirectory(filesOrdirectories, filePath, fileClient))
            when "Azure::Storage::File::File"
              r.files.push(XSS::Converter::FileConverter::buildCloudFileListItemWithFile(filesOrdirectories, filePath, fileClient))
            end
          end
          nextMarker = result.continuation_token
          break unless nextMarker && !nextMarker.empty?
        end
        LoggingAspect::logger.info("List Files And Directories #{shareName}/#{directoryName} Successful")
        r
      end
    end
  end
end

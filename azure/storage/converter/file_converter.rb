require "azure/storage"
require_relative "core_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Converter
      class FileConverter
        def FileConverter.getFileService(handler, accountInfo)
          storageService = Azure::Storage::Converter::CoreConverter.getStorageService(handler, accountInfo)
          return storageService.file_client
        end
      end
    end
  end
end
require "azure/storage"
require_relative "core_converter"
require_relative "../utils"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Converter
    class FileConverter
      def FileConverter.getFileService(handler, accountInfo)
        storageService = XSS::Converter::CoreConverter.getStorageService(handler, accountInfo)
        return storageService.file_client
      end
    end
  end
end

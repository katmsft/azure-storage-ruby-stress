require "azure/storage"
require_relative "core_converter"
require_relative "../infrastructure/logging_aspect"


module Azure::Storage::Stress
  module Converter
    class TableConverter
      def TableConverter.getTableService(handler, accountInfo)
        storageService = XSS::Converter::CoreConverter.getStorageService(handler, accountInfo)
        return storageService.table_client
      end
    end
  end
end

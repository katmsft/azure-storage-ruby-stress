require "azure/storage"
require_relative "core_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Converter
      class TableConverter
        def TableConverter.getTableService(handler, accountInfo)
          storageService = Azure::Storage::Converter::CoreConverter.getStorageService(handler, accountInfo)
          return storageService.table_client
        end
      end
    end
  end
end

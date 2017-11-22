require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_table_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/table_converter"
require_relative "../infrastructure/logging_aspect"

module Azure
  module Storage
    module Handler
      class CloudTableClientHandler < BaseHandler
        def getServiceStats(requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def getServiceProperties(requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def setServiceProperties(serviceProperties, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def listTables(prefix, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end



        def ListTableSegmented(prefix, maxResults, continuationToken, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Return Value ==== #
        end
      end
    end
  end
end

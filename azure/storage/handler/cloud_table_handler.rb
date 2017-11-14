require_relative "base_handler"
require_relative "../auto_generated/core_types"
require_relative "../auto_generated/cloud_queue_client_types"
# require_relative "../auto_generated/cloud_queue_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/queue_converter"
require_relative "../infrastructure/logging_aspect"


module Azure
  module Storage
    module Handler
      class CloudTableHandler < BaseHandler
        def create(createIfNotExists, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def exists(requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def deleteTable(deleteIfExists, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def setPermissions(reqInfo, accountInfo, permissions)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def getPermissions(reqInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def Execute(operation, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def ExecuteBatch(operations, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def ExecuteQuery(tableQuery, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end



        def ExecuteQuerySegment(tableQuery, continuationToken, requestInfo, accountInfo)
          tableClient = Azure::Storage::Converter::TableConverter.getTableService(self, accountInfo)
          # ==== Construct Parameters ==== #
          # ==== Operation ==== #
          # ==== Construct Reture Value ==== #
        end
      end
    end
  end
end

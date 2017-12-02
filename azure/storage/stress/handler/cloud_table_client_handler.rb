require_relative "base_handler"
require_relative "../utils"
require_relative "../auto_generated/cloud_table_client_service"
require_relative "../converter/core_converter"
require_relative "../converter/table_converter"
require_relative "../infrastructure/logging_aspect"

module Azure::Storage::Stress
  module Handler
    class CloudTableClientHandler < BaseHandler
      def getServiceStats(requestInfo, accountInfo)
        tableClient = XSS::Converter::TableConverter.getTableService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def getServiceProperties(requestInfo, accountInfo)
        tableClient = XSS::Converter::TableConverter.getTableService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def setServiceProperties(serviceProperties, requestInfo, accountInfo)
        tableClient = XSS::Converter::TableConverter.getTableService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def listTables(prefix, requestInfo, accountInfo)
        tableClient = XSS::Converter::TableConverter.getTableService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end



      def ListTableSegmented(prefix, maxResults, continuationToken, requestInfo, accountInfo)
        tableClient = XSS::Converter::TableConverter.getTableService(self, accountInfo)
        # ==== Construct Parameters ==== #
        # ==== Operation ==== #
        # ==== Construct Return Value ==== #
      end
    end
  end
end

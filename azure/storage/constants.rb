require "logger"

module Azure
  module Storage
    module Constants
      module Service
        # Constant strings that represent the different services. These are used as part of Thrift's multiplexing
        # processor, which requires a map of handler interface to type discriminator (string). Services should use
        # these constants when adding items to a multiplexing processor
        CloudAppendBlob    = "CloudAppendBlob"
        CloudBlobClient    = "CloudBlobClient"
        CloudBlobContainer = "CloudBlobContainer"
        CloudBlob          = "CloudBlob"
        CloudBlockBlob     = "CloudBlockBlob"
        CloudFileClient    = "CloudFileClient"
        CloudFileDirectory = "CloudFileDirectory"
        CloudFile          = "CloudFile"
        CloudFileShare     = "CloudFileShare"
        CloudPageBlob      = "CloudPageBlob"
        CloudQueueClient   = "CloudQueueClient"
        CloudQueue         = "CloudQueue"
        CloudTableClient   = "CloudTableClient"
        CloudTable         = "CloudTable"
        SupportedFeatures  = "SupportedFeatures"
      end

      module Defaults
        LOGGER_LEVEL = Logger::DEBUG
      end
    end
  end
end

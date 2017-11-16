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

      module Constant
        TICKS_PER_SECOND = 10000000
        TICKS_PER_MILLISECOND = 10000
        UNIX_EPOCH_IN_MILLISECONDS = 62135596800000
        MILLISECONDS_PER_SECOND = 1000
      end
    end
  end
end

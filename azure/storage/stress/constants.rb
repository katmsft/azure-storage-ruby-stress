require "logger"

module Azure::Storage::Stress
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

    # Constant values
    NANO_SECONDS_PER_TICK = 100
    TICKS_PER_SECOND = 10000000
    TICKS_PER_MILLISECOND = 10000
    TICKS_PER_MICROSECOND = 10
    UNIX_EPOCH_IN_MILLISECONDS = 62135596800000
    UNIX_EPOCH_IN_TICKS = 621355968000000000
    MILLISECONDS_PER_SECOND = 1000
    MAX_ALLOWED_INSPECT_SIZE = 4096
    HTTP_METHODS = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "CONNECT", "OPTIONS"]

    # Error messages
    ERROR_CONTAINER_NOT_EXIST = "The specified container does not exist."
    ERROR_FILE_NOT_EXIST = "The specified resource does not exist."
    ERROR_PATH_NOT_EXIST = "The specified parent path does not exist."
    ERROR_TABLE_NOT_EXIST = "The specified resource does not exist."
    ERROR_BLOB_NOT_EXIST = "The specified blob does not exist."
    # TODO: validate the share error description
    ERROR_SHARE_NOT_EXIST = "The specified share does not exist."
    # TODO: validate the directory error description
    ERROR_DIRECTORY_NOT_EXIST = "The specified resource does not exist."
  end
end

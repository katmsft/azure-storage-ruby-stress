#
# Auto-generated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require "thrift"
require_relative "cloud_blob_service"
require_relative "blob_types"

module Azure::Storage::Stress
  module AutoGenerated
    module CloudBlockBlobService
      class Client < ::XSS::AutoGenerated::CloudBlobService::Client
        include ::Thrift::Client

        def putBlock(putBlockPayload, accountInfo)
          send_putBlock(putBlockPayload, accountInfo)
          return recv_putBlock()
        end

        def send_putBlock(putBlockPayload, accountInfo)
          send_message("putBlock", PutBlock_args, putBlockPayload: putBlockPayload, accountInfo: accountInfo)
        end

        def recv_putBlock()
          result = receive_message(PutBlock_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "putBlock failed: unknown result")
        end

        def putBlockList(requestInfo, accountInfo, blockList)
          send_putBlockList(requestInfo, accountInfo, blockList)
          return recv_putBlockList()
        end

        def send_putBlockList(requestInfo, accountInfo, blockList)
          send_message("putBlockList", PutBlockList_args, requestInfo: requestInfo, accountInfo: accountInfo, blockList: blockList)
        end

        def recv_putBlockList()
          result = receive_message(PutBlockList_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "putBlockList failed: unknown result")
        end

        def downloadBlockList(requestInfo, accountInfo, blockListingFilters)
          send_downloadBlockList(requestInfo, accountInfo, blockListingFilters)
          return recv_downloadBlockList()
        end

        def send_downloadBlockList(requestInfo, accountInfo, blockListingFilters)
          send_message("downloadBlockList", DownloadBlockList_args, requestInfo: requestInfo, accountInfo: accountInfo, blockListingFilters: blockListingFilters)
        end

        def recv_downloadBlockList()
          result = receive_message(DownloadBlockList_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "downloadBlockList failed: unknown result")
        end

        def uploadText(requestInfo, accountInfo, content, encoding)
          send_uploadText(requestInfo, accountInfo, content, encoding)
          return recv_uploadText()
        end

        def send_uploadText(requestInfo, accountInfo, content, encoding)
          send_message("uploadText", UploadText_args, requestInfo: requestInfo, accountInfo: accountInfo, content: content, encoding: encoding)
        end

        def recv_uploadText()
          result = receive_message(UploadText_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "uploadText failed: unknown result")
        end

        def downloadText(requestInfo, accountInfo, encoding)
          send_downloadText(requestInfo, accountInfo, encoding)
          return recv_downloadText()
        end

        def send_downloadText(requestInfo, accountInfo, encoding)
          send_message("downloadText", DownloadText_args, requestInfo: requestInfo, accountInfo: accountInfo, encoding: encoding)
        end

        def recv_downloadText()
          result = receive_message(DownloadText_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "downloadText failed: unknown result")
        end

        def uploadFromStream(requestInfo, accountInfo, versions, segments, length)
          send_uploadFromStream(requestInfo, accountInfo, versions, segments, length)
          return recv_uploadFromStream()
        end

        def send_uploadFromStream(requestInfo, accountInfo, versions, segments, length)
          send_message("uploadFromStream", UploadFromStream_args, requestInfo: requestInfo, accountInfo: accountInfo, versions: versions, segments: segments, length: length)
        end

        def recv_uploadFromStream()
          result = receive_message(UploadFromStream_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "uploadFromStream failed: unknown result")
        end

        def uploadFromFile(requestInfo, accountInfo, path, fileMode)
          send_uploadFromFile(requestInfo, accountInfo, path, fileMode)
          return recv_uploadFromFile()
        end

        def send_uploadFromFile(requestInfo, accountInfo, path, fileMode)
          send_message("uploadFromFile", UploadFromFile_args, requestInfo: requestInfo, accountInfo: accountInfo, path: path, fileMode: fileMode)
        end

        def recv_uploadFromFile()
          result = receive_message(UploadFromFile_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "uploadFromFile failed: unknown result")
        end

        def setStandardBlobTier(requestInfo, accountInfo, blobTier)
          send_setStandardBlobTier(requestInfo, accountInfo, blobTier)
          return recv_setStandardBlobTier()
        end

        def send_setStandardBlobTier(requestInfo, accountInfo, blobTier)
          send_message("setStandardBlobTier", SetStandardBlobTier_args, requestInfo: requestInfo, accountInfo: accountInfo, blobTier: blobTier)
        end

        def recv_setStandardBlobTier()
          result = receive_message(SetStandardBlobTier_result)
          return result.success unless result.success.nil?
          raise result.wse unless result.wse.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, "setStandardBlobTier failed: unknown result")
        end
      end

      class Processor < ::XSS::AutoGenerated::CloudBlobService::Processor
        include ::Thrift::Processor

        def process_putBlock(seqid, iprot, oprot)
          args = read_args(iprot, PutBlock_args)
          result = PutBlock_result.new()
          begin
            result.success = @handler.putBlock(args.putBlockPayload, args.accountInfo)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "putBlock", seqid)
        end

        def process_putBlockList(seqid, iprot, oprot)
          args = read_args(iprot, PutBlockList_args)
          result = PutBlockList_result.new()
          begin
            result.success = @handler.putBlockList(args.requestInfo, args.accountInfo, args.blockList)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "putBlockList", seqid)
        end

        def process_downloadBlockList(seqid, iprot, oprot)
          args = read_args(iprot, DownloadBlockList_args)
          result = DownloadBlockList_result.new()
          begin
            result.success = @handler.downloadBlockList(args.requestInfo, args.accountInfo, args.blockListingFilters)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "downloadBlockList", seqid)
        end

        def process_uploadText(seqid, iprot, oprot)
          args = read_args(iprot, UploadText_args)
          result = UploadText_result.new()
          begin
            result.success = @handler.uploadText(args.requestInfo, args.accountInfo, args.content, args.encoding)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "uploadText", seqid)
        end

        def process_downloadText(seqid, iprot, oprot)
          args = read_args(iprot, DownloadText_args)
          result = DownloadText_result.new()
          begin
            result.success = @handler.downloadText(args.requestInfo, args.accountInfo, args.encoding)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "downloadText", seqid)
        end

        def process_uploadFromStream(seqid, iprot, oprot)
          args = read_args(iprot, UploadFromStream_args)
          result = UploadFromStream_result.new()
          begin
            result.success = @handler.uploadFromStream(args.requestInfo, args.accountInfo, args.versions, args.segments, args.length)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "uploadFromStream", seqid)
        end

        def process_uploadFromFile(seqid, iprot, oprot)
          args = read_args(iprot, UploadFromFile_args)
          result = UploadFromFile_result.new()
          begin
            result.success = @handler.uploadFromFile(args.requestInfo, args.accountInfo, args.path, args.fileMode)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "uploadFromFile", seqid)
        end

        def process_setStandardBlobTier(seqid, iprot, oprot)
          args = read_args(iprot, SetStandardBlobTier_args)
          result = SetStandardBlobTier_result.new()
          begin
            result.success = @handler.setStandardBlobTier(args.requestInfo, args.accountInfo, args.blobTier)
          rescue ::XSS::AutoGenerated::WrappedStorageException => wse
            result.wse = wse
          end
          write_result(result, oprot, "setStandardBlobTier", seqid)
        end
      end

      # HELPER FUNCTIONS AND STRUCTURES

      class PutBlock_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        PUTBLOCKPAYLOAD = 1
        ACCOUNTINFO = 2

        FIELDS = {
          PUTBLOCKPAYLOAD => { type: ::Thrift::Types::STRUCT, name: "putBlockPayload", class: ::XSS::AutoGenerated::PutBlockPayload },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class PutBlock_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class PutBlockList_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        BLOCKLIST = 3

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          BLOCKLIST => { type: ::Thrift::Types::LIST, name: "blockList", element: { type: ::Thrift::Types::STRING } }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class PutBlockList_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class DownloadBlockList_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        BLOCKLISTINGFILTERS = 3

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          BLOCKLISTINGFILTERS => { type: ::Thrift::Types::I32, name: "blockListingFilters", enum_class: ::XSS::AutoGenerated::BlockListingFilters }
        }

        def struct_fields; FIELDS; end

        def validate
          unless @blockListingFilters.nil? || ::XSS::AutoGenerated::BlockListingFilters::VALID_VALUES.include?(@blockListingFilters)
            raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Invalid value of field blockListingFilters!")
          end
        end

        ::Thrift::Struct.generate_accessors self
      end

      class DownloadBlockList_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::DownloadBlockListResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadText_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        CONTENT = 3
        ENCODING = 4

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          CONTENT => { type: ::Thrift::Types::STRING, name: "content" },
          ENCODING => { type: ::Thrift::Types::STRING, name: "encoding" }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadText_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class DownloadText_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        ENCODING = 3

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          ENCODING => { type: ::Thrift::Types::STRING, name: "encoding" }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class DownloadText_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::BlobDownloadTextResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadFromStream_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        VERSIONS = 3
        SEGMENTS = 4
        LENGTH = 5

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          VERSIONS => { type: ::Thrift::Types::LIST, name: "versions", element: { type: ::Thrift::Types::I32 } },
          SEGMENTS => { type: ::Thrift::Types::LIST, name: "segments", element: { type: ::Thrift::Types::I32 } },
          LENGTH => { type: ::Thrift::Types::I64, name: "length" }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadFromStream_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadFromFile_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        PATH = 3
        FILEMODE = 4

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          PATH => { type: ::Thrift::Types::STRING, name: "path" },
          FILEMODE => { type: ::Thrift::Types::I32, name: "fileMode", enum_class: ::XSS::AutoGenerated::FileMode }
        }

        def struct_fields; FIELDS; end

        def validate
          unless @fileMode.nil? || ::XSS::AutoGenerated::FileMode::VALID_VALUES.include?(@fileMode)
            raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Invalid value of field fileMode!")
          end
        end

        ::Thrift::Struct.generate_accessors self
      end

      class UploadFromFile_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class SetStandardBlobTier_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        REQUESTINFO = 1
        ACCOUNTINFO = 2
        BLOBTIER = 3

        FIELDS = {
          REQUESTINFO => { type: ::Thrift::Types::STRUCT, name: "requestInfo", class: ::XSS::AutoGenerated::BlobRequestInfo },
          ACCOUNTINFO => { type: ::Thrift::Types::STRUCT, name: "accountInfo", class: ::XSS::AutoGenerated::StorageAccountInfo },
          BLOBTIER => { type: ::Thrift::Types::I32, name: "blobTier", enum_class: ::XSS::AutoGenerated::StandardBlobTier }
        }

        def struct_fields; FIELDS; end

        def validate
          unless @blobTier.nil? || ::XSS::AutoGenerated::StandardBlobTier::VALID_VALUES.include?(@blobTier)
            raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Invalid value of field blobTier!")
          end
        end

        ::Thrift::Struct.generate_accessors self
      end

      class SetStandardBlobTier_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        WSE = 1

        FIELDS = {
          SUCCESS => { type: ::Thrift::Types::STRUCT, name: "success", class: ::XSS::AutoGenerated::CloudBlobResponse },
          WSE => { type: ::Thrift::Types::STRUCT, name: "wse", class: ::XSS::AutoGenerated::WrappedStorageException }
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end
    end
  end
end

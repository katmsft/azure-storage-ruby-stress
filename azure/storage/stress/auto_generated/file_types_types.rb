#
# Auto-generated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require "thrift"
require_relative "core_types"


module Azure::Storage::Stress
  module AutoGenerated
    module ThriftSharedAccessFilePermissions
      None = 0
      Read = 1
      Write = 2
      Delete = 4
      List = 8
      Create = 16
      VALUE_MAP = { 0 => "None", 1 => "Read", 2 => "Write", 4 => "Delete", 8 => "List", 16 => "Create" }
      VALID_VALUES = Set.new([None, Read, Write, Delete, List, Create]).freeze
    end

    class FilePathInfo
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SHARENAME = 1
      DIRECTORYNAME = 2
      FILENAME = 3
      SNAPSHOTTIME = 4

      FIELDS = {
        SHARENAME => { type: ::Thrift::Types::STRING, name: "shareName" },
        DIRECTORYNAME => { type: ::Thrift::Types::STRING, name: "directoryName" },
        FILENAME => { type: ::Thrift::Types::STRING, name: "fileName", optional: true },
        SNAPSHOTTIME => { type: ::Thrift::Types::STRING, name: "snapshotTime", optional: true }
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field shareName is unset!") unless @shareName
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field directoryName is unset!") unless @directoryName
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ThriftFileRequestOptions
      include ::Thrift::Struct, ::Thrift::Struct_Union
      LOCATIONMODE = 1
      SERVERTIMEOUTSECONDS = 2
      MAXIMUMEXECUTIONTIMESECONDS = 3
      PARALLELOPERATIONTHREADCOUNT = 4
      USETRANSACTIONALMD5 = 5
      STOREFILECONTENTMD5 = 6
      DISABLECONTENTMD5VALIDATION = 7

      FIELDS = {
        LOCATIONMODE => { type: ::Thrift::Types::I32, name: "locationMode", optional: true, enum_class: ::XSS::AutoGenerated::LocationMode },
        SERVERTIMEOUTSECONDS => { type: ::Thrift::Types::I32, name: "serverTimeoutSeconds", optional: true },
        MAXIMUMEXECUTIONTIMESECONDS => { type: ::Thrift::Types::I32, name: "maximumExecutionTimeSeconds", optional: true },
        PARALLELOPERATIONTHREADCOUNT => { type: ::Thrift::Types::I32, name: "parallelOperationThreadCount", optional: true },
        USETRANSACTIONALMD5 => { type: ::Thrift::Types::BOOL, name: "useTransactionalMd5", optional: true },
        STOREFILECONTENTMD5 => { type: ::Thrift::Types::BOOL, name: "storeFileContentMd5", optional: true },
        DISABLECONTENTMD5VALIDATION => { type: ::Thrift::Types::BOOL, name: "disableContentMd5Validation", optional: true }
      }

      def struct_fields; FIELDS; end

      def validate
        unless @locationMode.nil? || ::XSS::AutoGenerated::LocationMode::VALID_VALUES.include?(@locationMode)
          raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Invalid value of field locationMode!")
        end
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ThriftFileContinuationToken
      include ::Thrift::Struct, ::Thrift::Struct_Union
      NEXTMARKER = 1
      STORAGELOCATION = 2

      FIELDS = {
        NEXTMARKER => { type: ::Thrift::Types::STRING, name: "nextMarker" },
        STORAGELOCATION => { type: ::Thrift::Types::I32, name: "storageLocation", optional: true, enum_class: ::XSS::AutoGenerated::StorageLocation }
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field nextMarker is unset!") unless @nextMarker
        unless @storageLocation.nil? || ::XSS::AutoGenerated::StorageLocation::VALID_VALUES.include?(@storageLocation)
          raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Invalid value of field storageLocation!")
        end
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ThriftFileShareStats
      include ::Thrift::Struct, ::Thrift::Struct_Union
      USAGE = 1

      FIELDS = {
        USAGE => { type: ::Thrift::Types::I32, name: "usage" }
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field usage is unset!") unless @usage
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ThriftSharedAccessFilePolicy
      include ::Thrift::Struct, ::Thrift::Struct_Union
      PERMISSIONS = 1
      EXPIRYTIME = 2
      STARTTIME = 3

      FIELDS = {
        PERMISSIONS => { type: ::Thrift::Types::STRING, name: "permissions" },
        EXPIRYTIME => { type: ::Thrift::Types::I64, name: "expiryTime", optional: true },
        STARTTIME => { type: ::Thrift::Types::I64, name: "startTime", optional: true }
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field permissions is unset!") unless @permissions
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ThriftFileSharePermissions
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SHAREDACCESSPOLICIES = 1

      FIELDS = {
        SHAREDACCESSPOLICIES => { type: ::Thrift::Types::MAP, name: "sharedAccessPolicies", key: { type: ::Thrift::Types::STRING }, value: { type: ::Thrift::Types::STRUCT, class: ::XSS::AutoGenerated::ThriftSharedAccessFilePolicy } }
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, "Required field sharedAccessPolicies is unset!") unless @sharedAccessPolicies
      end

      ::Thrift::Struct.generate_accessors self
    end
  end
end

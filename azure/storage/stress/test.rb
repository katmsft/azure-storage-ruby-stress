# require "thrift"
# require_relative "service_handlers"

# begin
#   port = ARGV[0] || 9090

#   transport = Thrift::BufferedTransport.new(Thrift::Socket.new("localhost", port))
#   protocol = Thrift::BinaryProtocol.new(transport)
#   client1 = Azure::Storage::AutoGenerated::SupportedFeatures::Client.new(protocol)
#   client2 = Azure::Storage::AutoGenerated::SupportedFeatures::Client.new(protocol)

#   transport.open()

#   supported_features1 = client1.GetSupportedFeatures()
#   supported_features2 = client2.GetSupportedFeatures()

#   #---------------------------------------------------------|
#   # Begin debug code snippet
#   puts "\n" + "supported_features1".rjust(40, "-").ljust(80, "-") + "\n"
#   puts "supported_features1 is :" + "\n"
#   require "pp"
#   pp supported_features1
#   puts "\n" + "supported_features1".rjust(40, "-").ljust(80, "-") + "\n"
#   # Ends debug code snippet
#   #---------------------------------------------------------|

#   #---------------------------------------------------------|
#   # Begin debug code snippet
#   puts "\n" + "supported_features2".rjust(40, "-").ljust(80, "-") + "\n"
#   puts "supported_features2 is :" + "\n"
#   require "pp"
#   pp supported_features2
#   puts "\n" + "supported_features2".rjust(40, "-").ljust(80, "-") + "\n"
#   # Ends debug code snippet
#   #---------------------------------------------------------|

#   transport.close()

# rescue Thrift::Exception => tx
#   print 'Thrift::Exception: ', tx.message, "\n"
# end

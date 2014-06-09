require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

host, port = 'localhost', 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets.chomp) && !line.empty?  # Read the request and collect it until it's empty
    lines << line
  end
  puts lines                                        # Output the full request to stdout

  filename = lines[0].gsub(/GET \//,'').gsub(/ HTTP.*/,'')

if File.exists?(filename)
	client.puts File.read(filename)
else
	client.puts File.read('index.html')
end

  #client.puts(response)                       # Output the current time to the client
  client.close                                      # Disconnect from the client
end

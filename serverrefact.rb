require 'socket'

class Server
	attr_accessor :client, :server, :lines, :filename
	
	def initialize(host,port)
		@server = TCPServer.open(host, port)                 
		puts "Server started on #{host}:#{port} ..." 
	end

	def getConnected
		@client = @server.accept   
	end

	def fillLines
		@lines = []
  		while (line = client.gets.chomp) && !line.empty?
    		lines << line
    	end
  	end

  	def toSTDout
  		puts @lines 
	end

	def snipIt
		@lines[0].gsub(/GET \//,'').gsub(/ HTTP.*/,'')
	end

	def checkRead(filename)
		if File.exists?(filename)
			client.puts File.read(filename)
		else
			client.puts File.read('index.html')
		end
	end

	def disconnect
		@client.close
	end

end

webServer = Server.new('localhost',2000)

loop do
	webServer.getConnected
	webServer.fillLines
	webServer.toSTDout
	webServer.checkRead(webServer.snipIt)
	webServer.disconnect
end

# I want you to:

# >Establish the TCPserver
# Do the loop
# 	>Accept the user's interaction
# 	>Accept the user's input, extract the usefull code and add it to an array
# 	>Output the lines you have amassed to the stdout 
# 	>Take the lines the user provided, extract the useful string and dump it into a variable
# 	>Test to see if our useful string exists and client.puts the matching file
# 		>If the string is empty, send the user somewhere
# 	> Disconnect the user

# 	Make sure you call upon each method in order to get this to run
Dir[File.join File.dirname(__FILE__), 'Server', '*.rb'].each do |file|
  require file
end

module Infineum::Server
  class Server

    MAX_LISTENERS = 5
    @running  = false

    def port
      99336
    end

    def start
      if @server.nil?
        @server = TCPServer.new(port)
        Thread.new do 
          while @server
            socket = @server.accept
            socket.puts 'Hello'
            socket.close
            @running = true
          end
        end

        #while @running == false 
        #end
      end
    end

    def stop
      @server = nil
      @running = false
    end

  end
end

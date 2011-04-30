

module Infineum::Server
  class Server

    MAX_LISTENERS = 5

    def port
      99434
    end

    def start
      if @server.nil?
        @server = TCPServer.new(port)
        Thread.new do 
          while @server
            socket = @server.accept
            @running = true
            action = ActionBuilder.new.build socket
            action.run
            socket.close if socket.closed? == false
          end
        end

      end
    end

    def stop
      @server = nil
    end

  end
end

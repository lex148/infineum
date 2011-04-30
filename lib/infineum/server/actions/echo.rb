
module Infineum::Server::Actions
  class Echo

    def initialize socket
      @socket = socket
    end

    def run
      @socket.puts 'Hello'
      @socket.close
    end

  end
end

module Infineum::Server::Actions
  class Noop

    def initialize socket
      @socket = socket
    end

    def run 
      @socket.close
    end

  end
end

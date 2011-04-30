module Infineum::Server
  class ActionBuilder

    ACTIONS = %w"Echo Noop" 

    def build socket
      action = socket.gets.capitalize.strip
      puts action
      if ACTIONS.index action 
        klass = eval("Infineum::Server::Actions::#{action}")
        klass.new(socket)
      else
        puts "WARNING: unknown action: #{action}"
        Noop.new socket
      end
    end

  end
end

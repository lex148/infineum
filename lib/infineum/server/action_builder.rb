module Infineum::Server
  class ActionBuilder

    def build socket
      action = socket.gets.capitalize.strip

      if Infineum::Server::Actions.const_defined?(action)
        klass = Infineum::Server::Actions.const_get(action)
        klass.new(socket)
      else
        puts "WARNING: unknown action: #{action}"
        Noop.new socket
      end
    end

  end
end

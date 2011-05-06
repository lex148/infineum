module Infineum::Server
  class ActionBuilder

    def self.build action
      if Infineum::Server::Actions.const_defined?(action.capitalize)
        klass = Infineum::Server::Actions.const_get(action.capitalize)
        klass.new
      else
        puts "WARNING: unknown action: #{action}"
        Noop.new socket
      end
    end

  end
end

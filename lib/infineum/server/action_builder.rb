module Infineum::Server
  class ActionBuilder

    def self.build action
      begin
        if Infineum::Server::Actions.const_defined?(action.capitalize)
          klass = Infineum::Server::Actions.const_get(action.capitalize)
          klass.new
        else
          Actions::Noop.new
        end
      rescue NameError
        Actions::Noop.new
      end
    end

  end
end

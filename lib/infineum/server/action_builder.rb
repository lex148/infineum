module Infineum::Server
  class ActionBuilder
    # ActionBuilder.build will create a new action from the given
    # string.
    #
    # Params:
    #   action ( String ) # => name of the action to create
    #
    # Returns:
    #   Action if the given action is defined or Noop
    def self.build action
      begin
        if Infineum::Server::Actions.const_defined?(action.capitalize)
          Infineum::Server::Actions.const_get(action.capitalize).new
        else
          Actions::Noop.new
        end
      rescue NameError
        Actions::Noop.new
      end
    end

  end
end

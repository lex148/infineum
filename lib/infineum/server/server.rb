

module Infineum::Server
  class Server
    def start
      EM::run {

      }
      action = ActionBuilder.new.build socket
      action.run
    end
  end
end

module Infineum::Server
  def receive_data data
    action = ActionBuilder.build data
    send_data action.run
  end
end

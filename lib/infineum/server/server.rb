module Infineum::Server
  def receive_data data
    args = data.split ' '
    action = ActionBuilder.build args[0]
    send_data action.run args
  end
end

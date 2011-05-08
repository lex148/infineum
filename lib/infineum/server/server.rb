module Infineum::Server
  # When the  server receives data, convert the  data into the  correct action,
  # then call the action.
  #
  # Supported Actions:
  #   Echo
  #   Noop
  #
  # Sends data from the action
  def receive_data data
    action = ActionBuilder.build data
    send_data action.run
  end
end

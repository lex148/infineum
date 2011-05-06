require 'helper'

module TestEchoClient
  def post_init
    send_data 'echo'
  end

  def receive_data data
    $response = data
    EM.stop
  end

end

describe Infineum::Server do
  context 'Start the Server' do
    it 'should echo a connection' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestEchoClient
      end

      $response.should == 'Hello'
    end
  end
end

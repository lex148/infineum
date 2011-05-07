require 'helper'

module TestOutputClient
  def receive_data data
    $response = data
    EM.stop
  end
end

module TestEchoClient
  include TestOutputClient

  def post_init
    send_data 'echo'
  end
end

module TestNoopClient
  include TestOutputClient

  def post_init
    send_data 'noop'
  end
end

module TestErrorClient
  include TestOutputClient

  def post_init
    send_data 'blah_blah_this_should_error_out'
  end
end

describe Infineum::Server do
  context 'Echo' do
    it 'should return a "Hello" message' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestEchoClient
      end
      $response.should == 'Hello'
    end
  end

  context 'Noop' do
    it 'should return a "Noop" message' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestNoopClient
      end
      $response.should == 'Noop'
    end
  end

  context 'Error' do
    it 'should return a "Noop" message when invalid data is sent' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestErrorClient
      end
      $response.should == 'Noop'
    end
  end
end

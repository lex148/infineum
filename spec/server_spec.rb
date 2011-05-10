require 'helper'

def SimpleClient action
  mod = Module.new do
    def receive_data data
      $response = data
      EM.stop
    end
  end

  mod.module_eval "def post_init() send_data '#{action}' end"
  mod
end

TestEchoClient  = SimpleClient 'echo'
TestNoopClient  = SimpleClient 'noop'
TestErrorClient = SimpleClient 'error'

describe Infineum::Server do
  before(:each) { $response = nil }

  context 'Echo' do
    it 'should return a "Hello" message' do
      EM.run do
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestEchoClient
      end
      $response.should == 'Hello'
    end
  end

  context 'Noop' do
    it 'should return a "Noop" message' do
      EM.run do
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestNoopClient
      end
      $response.should == 'Noop'
    end
  end

  context 'Error' do
    it 'should return a "Noop" message when invalid data is sent' do
      EM.run do
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestErrorClient
      end
      $response.should == 'Noop'
    end
  end


end

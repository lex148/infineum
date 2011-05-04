require 'helper'

describe Infineum::Server do

  describe 'Start the Server' do

    before( :each ) do
      @server = Infineum::Server::Server.new
    end

    after( :each ) do
      @server.stop
    end

    it 'should have a port default port' do
      @server.port.should == 99434
    end

    it 'should wait for conection' do 
      expect do
        @server.start 
        s = TCPSocket.open('localhost', @server.port)
        s.puts "echo"
        s.gets.strip.should == "Hello"
      end.to_not raise_error
    end

  end

end

require 'helper'

describe Infineum::Server do

  describe 'Start the Server' do

    before( :each ) do
      @server = Infineum::Server.new
    end

    after( :each ) do
      @server.stop
    end

    it 'should have a port default port' do
      @server.port.must_equal 99336
    end

    it 'should wait for conection' do 
      @server.start 
      s = TCPSocket.open('localhost', @server.port)
      s.puts "Hello"
      s.gets.strip.must_equal "Hello"
    end

  end

end

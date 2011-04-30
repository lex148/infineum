require 'helper'
require 'timeout'

describe Infineum::Server do

  describe 'Start the Server' do

    before( :each ) do
      @server = Infineum::Server::Server.new
    end

    after( :each ) do
      @server.stop
    end

    it 'should have a port default port' do
      @server.port.must_equal 99434
    end

    it 'should wait for conection' do 
      @server.start 
      s = TCPSocket.open('localhost', @server.port)
      begin
        timeout(5) do
          s.puts "echo"
          s.gets.strip.must_equal "Hello"
        end 
      rescue Timeout::Error
        s.close
        false.must_equal 'failed: Timeout'
      end
    end

  end

end

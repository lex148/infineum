require 'helper'

describe Infineum::Server do

  describe 'Start the Server' do

    before( :each ) do
      @server = Infineum::Server.new
    end

    it 'should have a port default port' do
      @server.port.must_equal 99334
    end

  end

end

require 'rubygems'
require 'bundler/setup'
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'infineum'

module EMTestHelper
  TimeoutError = Class.new StandardError

  # Kill the test if it is taking to long
  def setup_timeout timeout = TIMEOUT
    EM.schedule do
      EM.add_timer( timeout ) do
        raise TimeoutError, "Test was timed out after #{timeout} seconds."
      end
    end
  end

  # it's home to me
  def localhost
    '127.0.0.1'
  end

  # Pick one i don't care
  def port_in_use?(port, host="127.0.0.1")
    s = TCPSocket.new(host, port)
    s.close
    s
  rescue Errno::ECONNREFUSED
    false
  end

  # Use this port
  def next_port
    @@port ||= 9000
    begin
      @@port += 1
    end while port_in_use?(@@port)

    @@port
  end
end


Rspec.configure do |config|
  # Give the instances of rspec the powers of the module
  config.include EMTestHelper

  # setup the test
  config.before(:each) do
    setup_timeout
    @port = next_port
  end
end

TIMEOUT = 0.25

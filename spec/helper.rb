require 'rubygems'
require 'bundler/setup'
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'infineum'

module EMTestHelper
  TimeoutError = Class.new StandardError

  def setup_timeout timeout = TIMEOUT
    EM.schedule do
      EM.add_timer( timeout ) do
        raise TimeoutError, "Test was timed out after #{timeout} seconds."
      end
    end
  end

  def localhost
    '127.0.0.1'
  end

  def port_in_use?(port, host="127.0.0.1")
    s = TCPSocket.new(host, port)
    s.close
    s
  rescue Errno::ECONNREFUSED
    false
  end

  def next_port
    @@port ||= 9000
    begin
      @@port += 1
    end while port_in_use?(@@port)

    @@port
  end
end

Rspec.configure do |config|
  config.include EMTestHelper

  config.before(:each) do
    setup_timeout
    @port = next_port
  end
end

TIMEOUT = 0.25

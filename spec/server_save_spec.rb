require 'helper'

module TestSaveHandShakeClient
  include TestOutputClient

  def post_init
    send_data 'save for test_user'
  end
end


module TestSaveClientSave
  def receive_data data
    $response = data
    if $response == 'Granted'
      send_data 'fake_data_chunk'
    else
      EM.stop 
    end
  end

  def post_init
    send_data 'save for test_user'
  end
end



describe Infineum::Server do

  context 'Save' do
    it 'should return "Granted" message if Server accepts user for saving' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveHandShakeClient
      end
      $response.should == 'Granted'
    end
  end

  context 'Save' do
    it 'the after save handshake, should get saved massage' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientSave
      end
      $response.should == 'Saved'
    end
  end

  context 'Save' do
    it 'should store the chunk in the db' do
      r = Redis.new(:db => 'infineum')
      r.del('test_user')
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientSave
      end
      chunks = r.lrange('test_user',-10,-1)
      chunks.count.should > 0
    end
  end

end



require 'helper'

module TestSaveHandShakeClient
  include TestOutputClient

  def post_init
    send_data 'save for test_user'
  end
end


module TestSaveClientChunk
  def receive_data data
    $response = data
    if $response == 'Granted'
      send_data 'data:fake_data_chunk'
    else
      EM.stop 
    end
  end

  def post_init
    send_data 'save for test_user'
  end
end


module TestSaveClientPeerList
  def receive_data data
    $response = data
    if $response == 'Granted'
      send_data 'data:fake_data_chunk'
    elsif $response == 'Saved'
      send_data 'peers:0.0.0.0'
    else
      EM.stop 
    end
  end

  def post_init
    send_data 'save for test_user'
  end
end



describe Infineum::Server do

  before(:each) do
      @db = Redis.new()
      @hash = ('fake_data_chunk').to_hashcode.to_s 
      @db.del('test_user:chunks')
      @db.del(@hash + ':data')
      @db.del(@hash + ':peers')
  end

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
        EM.connect localhost, @port, TestSaveClientChunk
      end
      $response.should == 'Saved'
    end
  end

  context 'Save' do
    it 'should store the chunk in the db' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientChunk
      end
      data = @db[@hash + ':data']
      data.should == 'fake_data_chunk'
    end
  end

  context 'Save' do
    it 'should store the chunks hash in users chuck list' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientChunk
      end
      data = @db.lrange('test_user:chunks',-1,-1)
      data.index(@hash).should_not be nil
    end
  end

  
  context 'Save' do
    it 'should store the chunks hash in users chuck list' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientPeerList
      end
      data = @db[@hash + ':data']
      data = @db.lrange(@hash + ':peers',-1,-1)
      data.index('0.0.0.0').should_not be nil
    end
  end

end



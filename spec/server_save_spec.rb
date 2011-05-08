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

  before(:each) do
      @db = Redis.new(:db => 'infineum')
      @hash = Digest::MD5.hexdigest('fake_data_chunk').to_s 
      @db.del('test_user:chunks')
      @db.del(@hash + ':data')
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
        EM.connect localhost, @port, TestSaveClientSave
      end
      $response.should == 'Saved'
    end
  end

  context 'Save' do
    it 'should store the chunk in the db' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientSave
      end
      data = @db[@hash + ':data']
      #data dd= @db.lrange('test_user:chunks',-10,-1)
      data.should == 'fake_data_chunk'
    end
  end

  context 'Save' do
    it 'should store the chunks hash in users chuck list' do
      EM.run do
        $response = nil
        EM.start_server localhost, @port, Infineum::Server
        EM.connect localhost, @port, TestSaveClientSave
      end
      data = @db.lrange('test_user:chunks',-10,-1)
      data.select{|x| x == @hash}.size.should > 0
    end
  end
end



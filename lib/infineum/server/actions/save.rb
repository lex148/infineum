module Infineum::Server::Actions
  class Save



    def run(data)
      if @save_for.nil?
        handshake(data)
      elsif data.start_with?('data:')
        save_chunk(data)
      elsif data.start_with?('peers:') && @hash
        save_peer_list(data)
      else
        'Noop'
      end
    end


    def handshake( data )
      #TODO: check the black list for this user
      if data.start_with? 'save for'
        @save_for = data.split(' ')[2]
        'Granted'
      else
        'Denied' 
      end
    end


    def save_chunk data 
      data = data.slice(('data:'.size)..(data.size)).strip
      db = Redis.new()
      @hash = data.to_hashcode 
      db[@hash + ':data'] = data
      db.rpush( @save_for + ':chunks', @hash )
      'Saved'
    end


    def save_peer_list data 
      data = data.slice(('peers:'.size)..(data.size))
      peers = data.split(',')
      db = Redis.new()
      peers.each{|x| db.rpush(@hash + ':peers', x.strip )  }
      'Done'
    end

  end
end


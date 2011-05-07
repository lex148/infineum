module Infineum::Server::Actions
  class Save



    def run(data)
      if @save_for
        save(data)
      else
        handshake(data)
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

    def save data 

      'Saved'
    end

    end
end


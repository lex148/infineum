module Infineum::Server::Actions
  class Save

    def run(args)
    #TODO: check the black list for this user
      if args[1] == 'for'
        'Ok'
      else
        'Denied' 
      end
    end

  end
end


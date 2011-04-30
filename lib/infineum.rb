# Pulling in all the libs we need to get the job done
%w(socket).each do |lib|
  require lib
end

%w"infineum infineum/Server infineum/Server/Actions".each do |folder|
  # Requiring all of the files in the dir. 
  Dir[File.join File.dirname(__FILE__), folder, '*.rb'].each do |file|
    require file
  end
end



module Infineum
end


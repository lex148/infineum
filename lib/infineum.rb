# Pulling in all the libs we need to get the job done
%w(socket eventmachine redis digest/md5).each do |lib|
  require lib
end

%w"infineum infineum/server infineum/server/actions".each do |folder|
  # Requiring all of the files in the dir. 
  Dir[File.join File.dirname(__FILE__), folder, '*.rb'].each do |file|
    require file
  end
end

class String
  def to_hashcode
    Digest::MD5.hexdigest(self)
  end
end

module Infineum
end


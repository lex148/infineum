# Pulling in all the libs we need to get the job done
%w(socket).each do |lib|
  require lib
end

# Requiring all of the files in the lib dir. 
Dir[File.join File.dirname(__FILE__), 'infineum', '*.rb'].each do |file|
  require file
end

module Infineum
end


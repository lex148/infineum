require 'helper'

describe Infineum::Server::ActionBuilder do
  subject{ Infineum::Server::ActionBuilder }

  it 'should be able to build an "echo" action' do
    subject.build('echo').should be_an_instance_of Infineum::Server::Actions::Echo
  end

  it 'should be able to build an "noop" action' do
    subject.build('noop').should be_an_instance_of Infineum::Server::Actions::Noop
  end

  it 'should be able to build an "noop" action on invalid action name' do
    subject.build('not a real action').should be_an_instance_of Infineum::Server::Actions::Noop
  end
end

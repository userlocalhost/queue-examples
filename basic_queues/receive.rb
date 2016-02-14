#!/usr/bin/env ruby

require 'bunny'

c = Bunny.new(:host => 'mq-server', :user => 'tsuchinoko', :password => 'passwd')
c.start

ch = c.create_channel
q = ch.queue('default-queue')

begin
  q.subscribe(:block => true) do |delivery_info, properties, data|
    puts data
  end
rescue Exception => _
  ch.close
  c.close
end

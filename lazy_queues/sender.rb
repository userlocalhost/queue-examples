#!/usr/bin/env ruby

require 'bunny'

c = Bunny.new(:host => 'mq-server', :user => 'tsuchinoko', :password => 'passwd')
c.start

ch = c.create_channel
q = ch.queue('lazy-queue', :arguments => {'x-queue-mode' => 'lazy'})

begin
  loop do
    q.publish('a' * 1024)
  end
rescue Exception => _
  ch.close
  c.close
end

require 'pathname'
require 'ole/base'
require 'ole/storage'
require 'juno/message'

module Juno
  class Folder

    def initialize(name, path)
      @name = name
      @path = Pathname.new(path)
    end

    def messages
      return @messages if defined? @messages
      ole = Ole::Storage.new(@path.to_s)
      @messages = ole.root.children.map do |message_dirent|

        # This condition is met once per folder, when
        # the dirent's name_utf16 is "directory"
        next if message_dirent.children.nil?
        
        body = message_dirent.children[0].read
        
        headers = message_dirent.children[1].read
        headers = headers.lines
        headers.each(&:chomp!)

        # This condition is for emails from Juno, including advertisements
        # and announcements. These emails are a bit unusual in that they
        # lack a date header, so instead of dealing with whatever problems
        # that might cause, they're of so little interest to anybody that
        # we might as well just throw them away.
        next if headers.any?{|h| h =~ /^X-UNTD-MSG:\s+internal/}

        Message.new(headers, body)
      end

      @messages.compact!
      @messages
    end

    def name
      @name
    end

  end
end

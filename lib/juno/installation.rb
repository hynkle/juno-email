require 'pathname'
require 'juno/user'

module Juno
  class Installation

    def initialize(root_pathname, opts={})
      @root = Pathname.new(root_pathname)
      @opts = opts
    end

    def users
      return @users if defined? @users
      @users = Pathname.glob(@root + 'USER*').select do |p|
        p.directory? && p.basename.to_s.match(/^USER\d{4}$/)
      end.map do |user_path|
        User.new(user_path)
      end
    end

  end
end

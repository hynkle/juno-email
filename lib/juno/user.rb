require 'pathname'

module Juno
  class User

    def initialize(root_pathname)
      @root = Pathname.new(root_pathname)
    end

  end
end

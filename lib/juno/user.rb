require 'pathname'

module Juno
  class User

    def initialize(root_pathname)
      @root = Pathname.new(root_pathname)
    end

    def path_id
      @path_id ||= @root.basename
    end

  end
end

require 'pathname'

module Juno
  class Installation

    def initialize(root_pathname, opts={})
      @root = Pathname.new(root_pathname)
      @opts = opts
    end

  end
end

require 'pathname'

module Juno
  class Folder

    def initialize(name, path)
      @name = name
      @path = Pathname.new(path)
    end

    def name
      @name
    end

  end
end

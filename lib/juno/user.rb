require 'pathname'
require 'inifile'
require 'date'

module Juno
  class User

    def initialize(root_pathname)
      @root = Pathname.new(root_pathname)
    end

    def path_id
      @path_id ||= @root.basename
    end

    def login
      # ini_config['User Profile']['Login'] contains the same value
      @login ||= ini_config['UserInfo']['User']
    end

    def full_name
      @fullname ||= ini_config['User Profile']['Full name']
    end

    def last_connection
      return @last_connection if defined? @last_connection

      date = ini_config['History']['Last Connection Time']
      @last_connection = if date.nil? || !date.match(/^\d+\/\d+\/\d+$/)
        nil
      else
        day, month, year = date.split('/').map(&:to_i)
        Date.new(year, month, day)
      end
    end

    def juno_version
      @juno_version ||= ini_config['Configuration']['Juno Version']
    end

    private

    def ini_config
      return @ini_config if defined? @ini_config

      ini_path = @root.join('juno.ini')
      unless ini_path.file?
        raise "missing expected junio.ini at #{ini_path}"
      end
      @ini_config = IniFile.load(ini_path)
    end

  end
end

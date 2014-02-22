require 'pathname'
require 'inifile'
require 'date'
require 'set'
require 'juno/folder'

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

    def folders
      return @folders if defined? @folders

      director_path = @root.join('director.frm')
      unless director_path.file?
        raise "missing expected director.frm at #{director_path}"
      end

      @folders = []

      @folders = director_path.readlines(encoding: 'ASCII-8BIT').map do |line|
        matchdata = line.match(/^(\S+) (fold\d{4}\.frm)\b/)
        next unless matchdata
        name = matchdata[1]
        name.gsub!('\_', ' ')     # spaces in folder names are represented as '\ '
        name.gsub!('\\\\', '\\')  # backslashes in folder names are represented as '\\'
        filename = matchdata[2]
        Folder.new(name, @root.join(filename))
      end

      @folders.compact!
    end

    def contains_duplicate_messages?
      @contains_duplicate_messages ||= Set.new(all_messages).count != all_messages.count
    end

    def all_messages
      folders.flat_map(&:messages)
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

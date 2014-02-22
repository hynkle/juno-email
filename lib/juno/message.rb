module Juno
  class Message

    def initialize(headers, body)
      @headers = headers
      @body = body
    end

    def headers
      @headers
    end

    def body
      @body
    end

    def to_eml
      [@headers.join(?/), @body].join(?/)
    end

    def to_s
      to_eml
    end

    def to_mbox
      # a message in mbox is delineated by a line that starts with "From "
      from_line = headers.detect{|f| f.match(/^From:/)}.sub(/^From:\s+/, 'From ')

      # We need to escape any lines that start with "From " in the body,
      # so that they aren't mistaken for the start of a new message.
      # To prevent ambiguity, we also alter any body lines that start
      # with ">From" to ">>From".
      escaped_body = body.gsub(/^(>?From )/, '>\1')

      [from_line, headers.join($/), escaped_body].join($/)
    end

    def ==(other)
      self.headers == other.headers && self.body == other.body
    end

    def hash
      to_s.hash
    end

    def eql?(other)
      self == other
    end

  end
end

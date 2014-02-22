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

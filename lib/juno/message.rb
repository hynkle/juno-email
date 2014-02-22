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

  end
end

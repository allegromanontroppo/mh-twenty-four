# frozen_string_literal: true

module Postcodes
  class PostcodesIo
    URL_ROOT = 'http://api.postcodes.io'
    NOT_FOUND_MESSAGE = 'Postcode not found'
    INVALID_MESSAGE = 'Invalid postcode'

    def initialize(post_code:)
      @post_code = post_code
    end

    def ok?
      response.status == 200
    end

    def invalid?
      error_message == INVALID_MESSAGE
    end

    def not_found?
      error_message == NOT_FOUND_MESSAGE
    end

    def result
      raise error_message unless body['status'] == 200

      Result.new(body.dig('result', 'postcode'), body.dig('result', 'lsoa'))
    end

    def error_message
      body['error']
    end

    private

    attr_reader :post_code

    def body
      @body ||= JSON.parse(response.body)
    end

    def response
      @response ||= connection.get(path)
    end

    def connection
      @connection ||= Faraday.new(
        url: URL_ROOT,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def path
      URI::Parser.new.escape "/postcodes/#{post_code}"
    end
  end
end

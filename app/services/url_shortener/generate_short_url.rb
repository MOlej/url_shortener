# frozen_string_literal: true

module UrlShortener
  class GenerateShortUrl
    def initialize(length:)
      @length = length
    end

    def call
      chars = [*'0'..'9', *'A'..'Z', *'a'..'z']
      (0...length).map { chars.sample }.join
    end

    private

    attr_reader :length
  end
end

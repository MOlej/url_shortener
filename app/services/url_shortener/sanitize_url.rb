module UrlShortener
  class SanitizeUrl
    def initialize(url:)
      @redirect_url = url
    end

    def call
      url = redirect_url.strip.gsub(/(http(s)?:\/\/)|(www\.)/, '')
      "https://#{url}"
    end

    private

    attr_reader :redirect_url
  end
end

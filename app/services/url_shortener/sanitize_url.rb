module UrlShortener
  class SanitizeUrl
    def initialize(url:)
      @redirect_url = url
    end

    def call
      url = redirect_url.strip.downcase.gsub(/(http?:\/\/)|(www\.)/, '')
      "https://#{url}"
    end

    private

    attr_reader :redirect_url
  end
end

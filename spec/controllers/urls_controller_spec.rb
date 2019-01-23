# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let(:valid_url) { { original_url: 'https://google.com' } }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    subject(:short_url) do
      post :create, params: { url: valid_url }
      Url.last
    end

    it 'redirects to the shortened url view' do
      expect(response).to redirect_to(show_url_path(short_url.shortened_url))
    end

    it 'creates a valid shortened url' do
      expect(short_url).to be_valid
    end

    context 'for url that is already in database' do
      it 'shows already existing shortened url' do
        post :create, params: { url: valid_url }

        expect(response).to redirect_to(show_url_path(short_url.shortened_url))
      end
    end
  end

  describe 'GET #redirect_to_original_url' do
    context 'for valid urls' do
      it 'redirects to the original url' do
        url = build(:url)
        valid_urls = ['www.google.com', 'http://www.google.com', 'https://www.google.com', 'google.com', 'http://google.com', 'https://google.com']

        valid_urls.each do |original_url|
          url.original_url = original_url
          url.save

          get :redirect_to_original_url, params: { shortened_url: url.shortened_url }

          sanitized_url = UrlShortener::SanitizeUrl.new(url: url.original_url).call
          expect(response).to redirect_to(sanitized_url)
        end
      end
    end
  end
end

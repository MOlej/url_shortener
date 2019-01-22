# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  context 'with invalid original url' do
    it 'should not be valid' do
      url = build(:url)
      invalid_urls = ['google.c', 'www.g$$gle.com', 'ahttps:\\google.com', 'ftp:\\ftp.co']

      invalid_urls.each do |invalid_url|
        url.original_url = invalid_url
        expect(url).to_not be_valid
      end
    end
  end

  context 'with invalid shortened url' do
    it 'should not be valid' do
      url = build(:url)
      invalid_short_urls = ['c', 'qwerty123!', '1234 1234', 'google.com']

      invalid_short_urls.each do |invalid_short_url|
        url.shortened_url = invalid_short_url
        expect(url).to_not be_valid
      end
    end
  end
end

# frozen_string_literal: true

class Url < ApplicationRecord
  SHORT_URL_LENGTH = 8

  validates :original_url, presence: true
  validates :original_url,
            format: { with: %r{\A(?:(?:http|https)://)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:/[-a-zA-Z0-9@,!:%_\+.~#?&//=]*)?\z} }

  validates :shortened_url, presence: true, uniqueness: true, length: { is: SHORT_URL_LENGTH }
  validates :shortened_url, format: { with: /[a-zA-Z0-9]/ }
end

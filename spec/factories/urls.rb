# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    shortened_url { Faker::Internet.password(8, 8) }
  end
end

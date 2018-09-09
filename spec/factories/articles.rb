# frozen_string_literal: true
FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "article-#{n}" }
  end
end

# frozen_string_literal: true
FactoryBot.define do
  factory :comment do
    sequence(:body) { |n| "comment-#{n}" }
  end
end

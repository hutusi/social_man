# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }

    factory :john do
      name { "John Doe" }
    end

    factory :sam do
      name { "Sam Hi" }
    end
  end
end

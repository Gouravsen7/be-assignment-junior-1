# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    amount { Faker::Number.decimal(l_digits: 2) }
    description { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end

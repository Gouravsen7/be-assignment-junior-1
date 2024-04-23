# frozen_string_literal: true

FactoryBot.define do
  factory :shared_expense do
    amount { Faker::Number.decimal(l_digits: 2) }
    description { Faker::Lorem.sentence }
    association :paid_by_user, factory: :user
    association :share_by_user, factory: :user
    association :expense
  end
end

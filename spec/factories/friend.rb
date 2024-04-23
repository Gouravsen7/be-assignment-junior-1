# frozen_string_literal: true

FactoryBot.define do
  factory :friend do
    association :user
    friend_id { user.id }
  end
end

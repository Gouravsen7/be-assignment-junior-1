# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :get_user_friends, -> (user_id) { where(friend_id: user_id)}
end

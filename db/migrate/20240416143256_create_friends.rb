# frozen_string_literal: true

class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.references :user

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateSharedExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_expenses do |t|
      t.float :amount
      t.text :description
      t.integer :share_user_id
      t.integer :paid_by_id
      t.references :expense

      t.timestamps
    end
  end
end

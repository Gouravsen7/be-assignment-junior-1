# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.text :description
      t.float :amount
      t.integer :paid_by
      t.references :user

      t.timestamps
    end
  end
end

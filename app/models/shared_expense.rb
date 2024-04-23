# frozen_string_literal: true

class SharedExpense < ApplicationRecord
  belongs_to :expense
  belongs_to :paid_by_user, class_name: :User, foreign_key: :paid_by_id
  belongs_to :share_by_user, class_name: :User, foreign_key: :share_user_id

  def self.total_owed(current_user)
    where(expense_id: Expense.expense(current_user)).sum(:amount)
  end
end

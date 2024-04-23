# frozen_string_literal: true

module ExpenseLogic
  extend ActiveSupport::Concern

  def distribute_expense(expense, user_ids, unequally_distributed_amounts, payee_id)
    if unequally_distributed_amounts.blank?
      distribute_evenly(expense, user_ids, payee_id)
    else
      distribute_unevenly(expense, unequally_distributed_amounts)
    end
  end

  def distribute_evenly(expense, user_ids, _payee_id)
    shared_amount = (expense.amount / user_ids.count).round(2)
    user_ids.each do |share_user_id|
      next if share_user_id.to_i == expense.paid_by

      expense.shared_expenses.create(amount: shared_amount, description: expense.description,
                                     share_user_id: share_user_id, paid_by_id: expense.paid_by)
    end
  end

  def distribute_unevenly(expense, unequally_amounts)
    unequally_amounts.each do |id, amount|
      next if id.to_i == expense.paid_by
      expense.shared_expenses.create(amount: amount, description: expense.description, share_user_id: id,
                                     paid_by_id: expense.paid_by)
    end
  end

  class_methods do
    def create_with_participants(expense_params, share_user_ids, shared_user_amounts, payee)
      user_ids = share_user_ids.reject(&:blank?)
      unequally_distributed_amounts = shared_user_amounts.to_unsafe_h.reject { |_key, value| value.blank? }
      ActiveRecord::Base.transaction do
        expense = payee.expenses.create!(expense_params)
        expense.distribute_expense(expense, user_ids, unequally_distributed_amounts, payee.id)
      rescue Exception => e  # Catch transaction rollback
        false
      end
    end
  end
end

# frozen_string_literal: true

class ExpensesController < ApplicationController
  def create
    expense = Expense.create_with_participants(expense_params, params['expense']['shared_user_ids'],
                                               params['shared_user_amounts'], current_user)
    if expense
      flash[:notice] = 'expense create successfully!'
    else
      flash[:alert] = "unable to create expense"
    end
    redirect_to root_path
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount, :paid_by)
  end
end

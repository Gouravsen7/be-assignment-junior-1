# frozen_string_literal: true

class StaticController < ApplicationController
  before_action :get_friends, :expense

  def dashboard
    @you_owe_user = current_user.owe_user
    @you_are_owed_user = current_user.owed_user
  end

  def people
    @expenses = Expense.where(user_id: params[:id])
  end

  private

  def get_friends
    @friends = User.where(id: current_user.friend_ids.uniq)
  end

  def expense
    @expense = Expense.new
  end
end
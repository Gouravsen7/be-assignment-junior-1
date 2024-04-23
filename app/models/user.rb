# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friends, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :paid_expenses, class_name: :SharedExpense, foreign_key: :paid_by_id, dependent: :destroy
  has_many :shared_expenses, class_name: :SharedExpense, foreign_key: :share_user_id, dependent: :destroy

  def not_friends_with_me
    User.where.not(id: friend_ids << id)
  end

  def owed_expenses
    paid_expenses.sum(:amount).round(2)
  end

  def owe_expenses
    shared_expenses.sum(:amount).round(2)
  end

  def owe_user
    shared_expenses.joins(:paid_by_user).group('paid_by_id', 'users.name').sum(:amount)
  end

  def owed_user
    paid_expenses.joins(:share_by_user).group('share_user_id','users.name').sum(:amount)
  end

  def get_friend_ids
    friends.pluck(:friend_id)
  end

  def friend_ids
    get_friend_ids.concat(Friend.get_user_friends(id).pluck(:user_id))
  end
end

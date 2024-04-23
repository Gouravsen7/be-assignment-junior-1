# frozen_string_literal: true

class Expense < ApplicationRecord
  include ExpenseLogic
  attr_accessor :shared_user_ids
  attr_accessor :shared_user_amounts

  belongs_to :user
  has_many :shared_expenses, dependent: :destroy

  validates :amount, :description, :paid_by, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def self.expense(user)
    where(paid_by: user.id).pluck(:id)
  end
end

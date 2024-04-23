# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { create(:user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:shared_expenses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:paid_by) }
  end

  describe 'class methods' do
    it 'should return expenses by user' do
      expect(Expense.expense(user)).to be_kind_of(Array)
    end
  end

  describe 'concern methods' do
    it { should respond_to(:distribute_expense) }
    it { should respond_to(:distribute_evenly) }
    it { should respond_to(:distribute_unevenly) }
    it { expect(described_class).to respond_to(:create_with_participants) }
  end
end

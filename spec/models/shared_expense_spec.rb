# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SharedExpense, type: :model do
  let(:user) { create(:user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'associations' do
    it { should belong_to(:expense) }
    it { should belong_to(:paid_by_user) }
    it { should belong_to(:share_by_user) }
  end

  describe 'class methods' do
    it 'should return expenses by user' do
      expect(SharedExpense.total_owed(user)).to be_kind_of(Float)
    end
  end
end

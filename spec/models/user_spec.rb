  # frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:friend) { create(:friend, user: user) }
  describe 'associations' do
    it { should have_many(:friends) }
    it { should have_many(:expenses) }
    it { should have_many(:paid_expenses) }
    it { should have_many(:shared_expenses) }
  end

  describe 'devise' do
    it 'is database authenticable' do
      expect(user.valid_password?('password123')).to be_truthy
    end
  end

  describe 'instance methods' do
    context 'attributes' do
      it { should respond_to(:email) }
      it { should respond_to(:password) }
      it { should respond_to(:password_confirmation) }
    end

    context 'associations' do
      it { should respond_to(:friends) }
      it { should respond_to(:expenses) }
      it { should respond_to(:paid_expenses) }
      it { should respond_to(:shared_expenses) }
    end

    context 'custom methods' do
      context 'not_friends_with_me' do
        before do
          create(:user)
          create(:friend, user: user)
        end
        it { should respond_to(:not_friends_with_me) }
        it 'returns all users that are not friends with the current user' do
          expect(user.not_friends_with_me.count).to eq(1)
        end
      end

      context 'owed_expenses' do
        before do
          expense = create(:expense, user: user, paid_by: user.id, amount: 100)
          create(:shared_expense, expense: expense, paid_by_user: user, amount: 100)
        end
        it { should respond_to(:owed_expenses) }
        it 'returns all expenses that are owed by the current user' do
          expect(user.owed_expenses).to eq(100)
        end
      end

      context 'owe_expenses' do
        let(:user_2) { create(:user) }
        before do
          expense = create(:expense, user: user_2, paid_by: user_2.id, amount: 100)
          create(:shared_expense, expense: expense, paid_by_user: user_2, amount: 100, share_by_user: user)
        end
        it { should respond_to(:owe_expenses) }
        it 'returns all expenses that are owed by the current user' do
          expect(user.owe_expenses).to eq(100)
        end
      end
    end
  end
end

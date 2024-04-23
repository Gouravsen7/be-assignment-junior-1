# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:shared_user) { create(:user) }
  render_views
  before(:each) do
    sign_in create(:user)
  end
  describe 'POST #create' do
    subject do
      post :create,
           params: { expense: { description: 'test', amount: 100, paid_by: user.id, shared_user_ids: [shared_user.id] },
                     shared_user_amounts: { shared_user.id => 100 } }
    end
    it 'returns http success' do
      expect(subject).to have_http_status(:redirect)
    end

    it 'creates expenses' do
      expect { subject }.to change(Expense, :count).from(0).to(1)
    end
  end
end

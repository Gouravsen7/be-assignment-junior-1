# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  before(:each) do
    sign_in create(:user)
  end
  describe 'GET #index' do
    subject do
      get :new
    end
    it 'returns http success' do
      expect(subject).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    subject do
      post :create, params: { friend: { friend_id: [user.id] } }
    end
    it 'returns http success' do
      expect(subject).to have_http_status(:redirect)
    end

    it 'creates a new friend' do
      expect { subject }.to change { Friend.count }.by(1)
    end
  end
end

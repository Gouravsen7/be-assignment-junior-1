# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:friend1) { create(:friend, user: user, friend_id: user2.id) }
  let(:friend2) { create(:friend, user: user2, friend_id: user3.id) }
  before(:each) do
    sign_in user
  end

  describe 'GET #home' do
    before do
      friend2
      friend1
    end
    it 'returns http success' do
      get :dashboard
      expect(response).to have_http_status(:success)
      expect(assigns(:friends)).to eq([friend2.user])
      expect(assigns(:expense)).to be_instance_of(Expense)
      expect(assigns(:you_owe_user)).to be_instance_of(Hash)
      expect(assigns(:you_are_owed_user)).to be_instance_of(Hash)
    end
  end

  describe 'GET #person' do
    it 'returns http success' do
      get :people, params: { id: user2.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:friends)).to eq([])
      expect(assigns(:expense)).to be_instance_of(Expense)
      expect(assigns(:expenses)).to eq([])
    end
  end
end

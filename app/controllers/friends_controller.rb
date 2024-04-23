# frozen_string_literal: true

class FriendsController < ApplicationController
  def new
    @friend = Friend.new
  end

  def create
    friend_ids = params['friend']['friend_id'].reject(&:blank?)
    friend_ids.each do |friend_id|
      friend = current_user.friends.new(friend_id: friend_id)
      unless friend.save
        flash[:alert] = "Failed to create friendship with friend #{friend_id}"
        redirect_back(fallback_location: root_path) and return
      end
    end
    flash[:notice] = 'friend add successfully'
    redirect_to root_path
  end
end

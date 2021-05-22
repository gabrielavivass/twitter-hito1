class FriendsController < ApplicationController

    def index
        @q = Tweet.ransack(params[:q])
        @tweet = Tweet.new
        if signed_in?
        @tweets = User.tweets_for_me(current_user).page(params[:page]).per(50)
        else
        redirect_to root_path, notice: "you must log in"
        end
    end

    def show
        @friends = Friend.all
    end
    
    def follow
        @followed = User.find(params[:id])
        @friend = Friend.new(user_id: current_user.id, friend_id: @followed.id)
        @friend.save
        redirect_to root_path, notice: "You are now following #{@followed.user_name}"
    end

    def unfollow
        
        friend = Friend.find_by(friend_id: params[:id], user_id: current_user)
        friend.destroy 
        redirect_to root_path, notice: "You no longer follow this user"
        
    end
end
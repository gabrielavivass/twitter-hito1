class FriendsController < ApplicationController
    
    def follow
        @followed = User.find(params[:id])
        @friend = Friend.new(user_id: current_user.id, friend_id: @followed.id)
        @friend.save
        redirect_to root_path, notice: "You are now following #{@followed.user_name}"
    end

    def unfollow
        
        friend = Friend.find_by(friend_id: params[:id], user_id: current_user)
        friend.destroy 
        redirect_to root_path, notice: "ya no sigues a este usuario"
        
    end
end
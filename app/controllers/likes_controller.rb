class LikesController < ApplicationController

    def create
        @like = current_user.likes.create(user_id: params[:user_id])
        # if @like.save
        redirect_back(fallback_location: root_path)
        # end
    end

    def destroy
        @like = Like.find_by(user_id: params[:user_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end

end

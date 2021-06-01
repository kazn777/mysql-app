class LikesController < ApplicationController
    def create #いいねボタン押下後のcreateアクション
        @like = current_user.likes.create(liked_user_id: params[:user_id])
        #params パラメータの取得
        redirect_back(fallback_location: root_path)
      end
    
      def destroy
        @like = Like.find_by(liked_user_id: params[:user_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
      end
end

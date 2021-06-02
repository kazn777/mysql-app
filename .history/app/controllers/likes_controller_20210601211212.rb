class LikesController < ApplicationController
    def create #いいねボタン押下後のcreateアクション
        @like = current_user.likes.create(liked_user_id: params[:user_id])
        #params フォーム等で送られたパラメータ情報を取得するメソッド
        #current_user サインインしてるユーザー
        #fallback_location 指定の場所にリダイレクトさせる
        redirect_back(fallback_location: root_path)
      end
    
      def destroy
        @like = Like.find_by(liked_user_id: params[:user_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
        #find_by:カラムを使ってレコードを検索し、最初に一致したものを返します。
      end
end

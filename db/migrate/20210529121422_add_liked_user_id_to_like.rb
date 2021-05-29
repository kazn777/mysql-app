class AddLikedUserIdToLike < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :liked_user, foreign_key: true
  end
end

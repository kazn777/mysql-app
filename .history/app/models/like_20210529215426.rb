class Like < ApplicationRecord
  belongs_to :user
  # validates_uniqueness_of :liked_user_id, scope: :user_id
end

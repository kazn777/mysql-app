class Like < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :_id, scope: :user_id
end

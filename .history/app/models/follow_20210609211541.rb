class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, :polymorphic => true
  #polymorphicオプション:参照先となるモデルをあらかじめ定義せず、参照元となるオブジェクトごとに指定する関連
  belongs_to :follower,   :polymorphic => true

  def block!
    self.update_attribute(:blocked, true)
    #selfメソッド:オブジェクトそのもの
  end

end

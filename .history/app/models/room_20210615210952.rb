class Room < ApplicationRecord
    has_many :entries, dependent: :destroy
    has_many :direct_messages, dependent: :destroy
    has_many :users, through: :entries
    #dependentオプション:モデルがdestroyされたときの、関係づけされたモデルに対する挙動を定義する
end

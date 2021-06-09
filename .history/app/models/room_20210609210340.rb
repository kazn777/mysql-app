class Room < ApplicationRecord
    has_many :messages, dependent: :destroy
    #dependentオプション:モデルがdestroyされたときの、関係づけされたモデルに対する挙動を定義する
end

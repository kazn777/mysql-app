class Room < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :entries, dependent: :destroy
    #dependentオプション:モデルがdestroyされたときの、関係づけされたモデルに対する挙動を定義する
end

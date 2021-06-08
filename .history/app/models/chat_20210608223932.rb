class Chat < ApplicationRecord
    belongs_to :user
    #belongs_to:参照元テーブルから参照先テーブルを参照するための設定
end

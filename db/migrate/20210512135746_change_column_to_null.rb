class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :prefecture_id, true
  end
end
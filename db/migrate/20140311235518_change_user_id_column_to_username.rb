class ChangeUserIdColumnToUsername < ActiveRecord::Migration
  def change
    add_column :comments, :username, :string
    remove_column :comments, :user_id
  end
end

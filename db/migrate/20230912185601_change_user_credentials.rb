class ChangeUserCredentials < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :username, false
    remove_column :users, :email
  end
end

class AddUserToPlacar < ActiveRecord::Migration[5.2]
  def change
    add_reference :placars, :user, foreign_key: true
  end
end

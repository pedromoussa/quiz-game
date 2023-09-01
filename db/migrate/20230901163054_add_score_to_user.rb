class AddScoreToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :placar, :integer
  end
end

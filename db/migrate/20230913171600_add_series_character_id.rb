class AddSeriesCharacterId < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :series_id, :string
    add_column :user_answers, :character_id, :string
  end
end

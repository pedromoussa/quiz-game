class AddIdTmdbToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :series, :id_tmdb, :string
  end
end

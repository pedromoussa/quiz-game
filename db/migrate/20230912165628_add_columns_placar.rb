class AddColumnsPlacar < ActiveRecord::Migration[5.2]
  def change
    add_column :placars, :questoes, :integer
    add_column :placars, :acertos, :integer
    add_column :placars, :percentual, :float

  end
end

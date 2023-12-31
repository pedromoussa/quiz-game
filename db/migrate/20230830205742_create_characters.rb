class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :nome_personagem
      t.string :nome_real
      t.string :url_foto
      t.references :series, foreign_key: true
      t.timestamps
    end
  end
end

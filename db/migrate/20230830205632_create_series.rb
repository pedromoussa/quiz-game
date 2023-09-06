class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :nome_pt
      t.string :nome_origem
      t.string :pais
      t.integer :popularidade
      t.float :media_votacao
      t.text :sinopse
      t.string :url_foto
      
      t.timestamps
    end
  end
end

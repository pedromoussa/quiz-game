class CreateQuizSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_series do |t|
      t.references :quiz, foreign_key: true
      t.references :series, foreign_key: true

      t.timestamps
    end
  end
end

class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.string :nome
      t.references :series, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end

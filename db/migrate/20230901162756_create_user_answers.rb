class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true
      t.string :resposta

      t.timestamps
    end
  end
end

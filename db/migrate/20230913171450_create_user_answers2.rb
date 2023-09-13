class CreateUserAnswers2 < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.references :user, foreign_key: true
      t.string :mensagem

      t.timestamps
    end
  end
end

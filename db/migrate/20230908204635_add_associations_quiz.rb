class AddAssociationsQuiz < ActiveRecord::Migration[5.2]
  def change
    add_reference :series, :quiz, foreign_key: true
    add_reference :characters, :quiz, foreign_key: true
  end
end

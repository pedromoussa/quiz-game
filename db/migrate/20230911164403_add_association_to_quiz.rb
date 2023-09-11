class AddAssociationToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_reference :quizzes, :main_series, foreign_key: { to_table: :series }
  end
end

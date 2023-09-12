class RenameColumnAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_answers, :resposta, :mensagem
  end
end

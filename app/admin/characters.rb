ActiveAdmin.register Character do
  actions :index

  index do
    selectable_column
    column :nome_personagem
    column :nome_real
    column :url_foto
  end

end

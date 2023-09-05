ActiveAdmin.register Character do
  actions :index

  index do
    selectable_column
    column :nome_personagem
    column :nome_real
    column :url_foto

    #column 'Elenco' do |character|
    #  link_to 'Buscar Elenco', fetch_cast_admin_character_path(character), method: :post
    #end

    #actions
  end

end

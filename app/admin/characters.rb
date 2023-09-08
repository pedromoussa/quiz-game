ActiveAdmin.register Character do
  actions :index

  index do
    selectable_column
    column :nome_personagem
    column :nome_real
    column "Foto" do |character|
      if character.url_foto.present?
        full_image_url = "https://image.tmdb.org/t/p/w300/#{character.url_foto}"
        image_tag full_image_url, height: "300"
      else
        "Nenhuma imagem disponivel"
      end
    end
    actions  
  end

end

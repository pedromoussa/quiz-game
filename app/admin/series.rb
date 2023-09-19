ActiveAdmin.register Series do
  actions :index, :show

  index do
    selectable_column
    column :nome_pt
    column :nome_origem
    column :pais
    column :popularidade
    column :media_votacao

    actions
  end

  filter :nome_pt, as: :string
  filter :nome_origem, as: :string
  filter :pais, as: :select, collection: Series.pluck(:pais).uniq

  filter :popularidade, as: :range_filter, label: "Popularidade Range" do |field|
    field.text_field :q_popularidade_gteq, placeholder: "Popularidade Min"
    field.text_field :q_popularidade_lteq, placeholder: "Popularidade Max"
  end

  filter :media_votacao, as: :range_filter, label: "Media Votacao Range" do |field|
    field.text_field :q_media_votacao_gteq, placeholder: "Media Votacao Min"
    field.text_field :q_media_votacao_lteq, placeholder: "Media Votacao Max"
  end

  collection_action :import_series, method: :post do
    @series_data = TmdbService.fetch_series() 

    if @series_data.present?
      @series_data.each do |series|
        new_series = Series.find_or_create_by(nome_origem: series[:nome_origem])
        new_series.update(series)
        @cast_data = TmdbService.fetch_cast(series[:id_tmdb])

        if @cast_data.present?
          @cast_data.each do |character|
            unless /self|Self|Host|Announcer/.match(character[:nome_personagem])
              new_series.character.create(character)
            end
          end
        end
      end
    else
      redirect_to "admin/series", alert: 'Falha ao buscar series'
    end
  end

  action_item :import_series do
    link_to "Importar séries", "/admin/series/import_series", method: :post
  end

  show do
    attributes_table do
      row :nome_pt
      row :nome_origem
      row :pais
      row :popularidade
      row :media_votacao
      row :sinopse
      row "Poster" do |poster|
        if poster.url_foto.present?
          full_image_url = "https://image.tmdb.org/t/p/w300/#{poster.url_foto}"
          image_tag full_image_url, height: "300"
        else
          "Nenhuma imagem disponivel"
        end
      end
      row 'Elenco' do
        link_to 'Ver Elenco', "/admin/characters?utf8=✓&q%5Bseries_id_eq%5D=#{series.id}&commit=Filter&order=id_desc"
      end
    end
  end

end

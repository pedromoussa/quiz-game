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
  filter :popularidade, as: :numeric
  filter :media_votacao, as: :numeric
  # filter :popularidade, as: :numeric_range
  # filter :media_votacao, as: :numeric_range

  collection_action :import_series, method: :post do
    num_series = params[:num_series] || 10 # valor default para testes
    @series_data = TmdbService.fetch_series(page: 1, per_page: num_series) 

    if @series_data.present?
      @series_data.each do |series|

        if !Series.find_by(nome_origem: series[:nome_origem])
          @new_series = Series.create(series)
          @cast_data = TmdbService.fetch_cast(series[:id_tmdb])

          if @cast_data.present?
            @cast_data.each do |character|
              new_char = character.merge({series: @new_series})
              p new_char
              new_character = Character.new(new_char)
              p new_character.valid?
              p new_character.errors
              
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
      row :url_foto

      row 'Elenco' do
        link_to 'Ver Elenco', "/admin/characters"
      end
    end
  end

end

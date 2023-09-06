ActiveAdmin.register Series do
  actions :index, :show

  index do
    selectable_column
    column :nome_pt
    column :nome_origem
    column :pais
    column :popularidade
    column :media_votacao

    # actions defaults: false do |series|
    #   action_item :fetch_cast, only: :show do
    #     link_to 'Buscar Elenco', fetch_cast_admin_series_path(series), method: :post
    #   end
      
    # end
    actions
  end

  filter :nome_pt, as: :string
  filter :nome_origem, as: :string
  filter :pais, as: :select, collection: Series.pluck(:pais).uniq
  filter :popularidade, as: :numeric
  filter :media_votacao, as: :numeric
  # filter :popularidade, as: :numeric_range
  # filter :media_votacao, as: :numeric_range

  # member_action :fetch_cast, method: :post do
  #   series = Series.find(params[:id])
  #   @cast_data = TmdbService.fetch_cast(series.series_id)

  #   if @cast_data.present?
  #     render 'admin/characters/fetched_cast', locals: { cast_data: @cast_data }
  #   else
  #     redirect_to admin_cast_path, alert: 'Falha ao buscar o elenco'
  #   end
  # end

  collection_action :import_series, method: :post do
    num_series = params[:num_series] || 10 # valor default para testes
    @series_data = TmdbService.fetch_series(page: 1, per_page: num_series) 

    if @series_data.present?
      @series_data.each do |series|
        Series.create(series) if !Series.find_by(nome_origem: series[:nome_origem])
        @cast_data = TmdbService.fetch_cast(series.id)
        if @cast_data.present?
          @cast_data.each do |character|
            Character.create(character)
          end
        else
          redirect_to admin_cast_path, alert: 'Falha ao buscar o elenco'
        end
      end
    else
      redirect_to admin_series_path, alert: 'Falha ao buscar series'
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

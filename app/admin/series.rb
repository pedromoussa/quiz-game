ActiveAdmin.register Series do
  actions :index, :show, :new, :create

  index do
    selectable_column
    column :nome_pt
    column :nome_origem
    column :pais
    column :popularidade
    column :media_votacao

    actions defaults: false do |series|
      action_item :fetch_cast, only: :show do
        link_to 'Buscar Elenco', fetch_cast_admin_series_path(series), method: :post
      end
  
      action_item :import_series, only: :show do
        link_to 'Importar Série', import_series_admin_series_path(series), method: :post
      end
    actions
  end

  filter :nome_pt, as: :string
  filter :nome_origem, as: :string
  filter :pais, as: :select, collection: Series.pluck(:pais).uniq
  # filter :popularidade, as: :numeric_range
  # filter :media_votacao, as: :numeric_range
  filter :popularidade, as: :numeric
  filter :media_votacao, as: :numeric

  action_item :fetch_series, only: :index do
    link_to 'Buscar Séries', fetch_series_admin_series_path
  end

  # importa todas as series recebidas pela api
  # collection_action :fetch_series, method: :get do
  #   series = TmdbService.fetch_series
  #   if series.present?
  #     series.each do |serie|
  #       Series.create(serie) if !Series.find_by(nome_origem: serie[:nome_origem])
  #     end
  #     redirect_to admin_series_path, notice: "Série importada com sucesso"
  #   end
  # end

  member_action :fetch_series, method: :get do
  end

  member_action :fetch_cast, method: :post do
    series = Series.find(params[:id])
    TmdbService.fetch_cast(series.series_id)
  
    redirect_to admin_series_path, notice: 'Elenco buscado com sucesso'
  end
  
  member_action :import_series, method: :post do
    series = Series.find(params[:id])
    TmdbService.import_series(series.series_id)
  
    redirect_to admin_series_path, notice: 'Série importada com sucesso'
  end

  show do
    attributes_table do
      row :nome_pt
      row :nome_origem
      row :pais
      row :popularidade
      row :media_votacao

      row 'Elenco' do
        link_to 'Ver Elenco', cast_admin_series_path(series)
      end
      row 'Buscar Séries' do
        link_to 'Buscar Séries', fetch_data_admin_series_path(series), method: :get
      end
      row 'Importar Série' do
        link_to 'Importar Série', import_data_admin_series_path(series), method: :post
      end
    end
  end
  
end

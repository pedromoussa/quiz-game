ActiveAdmin.register Series do
  actions :index, :show

  index do
    selectable_column
    column :nome_pt
    column :nome_origem
    column :pais
    column :popularidade
    column :media_votacao
    column 'Elenco' do |series|
      link_to 'Ver Elenco', cast_admin_series_path(series)
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

  member_action :fetch_series, method: :get do
    # Code to fetch data from the external API
    # You can display the fetched data to the admin for review
  end

  member_action :import_series, method: :post do
    # Code to import the Series data
    # For example, you can make an API call to fetch and import the data
    # Once imported, you can create or update Series records in your database
    redirect_to admin_series_path(resource), notice: 'Series imported successfully'
  end

  member_action :cast do
    # Code to fetch and display the cast of the selected Series
    # You can make an API call to get the cast data
    # Display the cast members or any relevant information
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

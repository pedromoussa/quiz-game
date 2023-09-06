ActiveAdmin.register_page "SeriesImport" do

  menu false

  content :only => :fetch_series do
    # render partial: 'admin/series_import/fetched_series', layout: 'active_admin', locals: {series_data: @series_data}
    render :partial => 'admin/series_import/index', locals: { series_data: @series_data }
  end

  page_action :fetch_series, method: :get do
    num_series = params[:num_series] || 10 # valor default para testes
    @series_data = TmdbService.fetch_series(page: 1, per_page: num_series) 

    if @series_data.present?
      @series_data.each do |series|
        Series.create(series) if !Series.find_by(nome_origem: series[:nome_origem])
      end
      render partial: 'admin/series_import/index', locals: {series_data: @series_data}
    else
      redirect_to admin_series_path, alert: 'Falha ao buscar series'
    end
  end

  page_action :import_series, method: :post do
    if @series_data.present?
      
      redirect_to admin_series_path, notice: "Séries importadas com sucesso"
    else
      redirect_to admin_series_path, notice: 'Falha ao importar as séries'
    end
  end

end
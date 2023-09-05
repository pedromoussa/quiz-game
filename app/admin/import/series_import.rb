ActiveAdmin.register_page "SeriesImport" do

  menu false

  page_action :fetch_series, method: :get do
    num_series = params[:num_series] || 10 # valor default para testes
    @series_data = TmdbService.fetch_series(page: 1, per_page: num_series) 

    if @series_data.present?
      # redirect_to
      render partial: 'admin/series/fetched_series', locals: {series_data: @series_data}
    else
      redirect_to admin_series_path, alert: 'Falha ao buscar series'
    end
  end

end
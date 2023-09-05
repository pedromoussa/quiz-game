class SeriesController < ApplicationController

	load_and_authorize_resource
	def this_fetch_series
		puts "chamando..."
		num_series = params[:num_series] || 10 # valor default para testes
		@series_data = TmdbService.fetch_series(page: 1, per_page: num_series)
		
		if @series_data.present?
			render partial: 'admin/series/fetched_series', locals: {series_data: @series_data}
		else
			redirect_to admin_series_path, alert: 'Falha ao buscar séries'
		end
	end
end

require "uri"
require "net/http"
require "json"

class TmdbService
  API_KEY = "5d1461001d40cb2ec078b29f176d1115"

  def self.fetch_series(page = 1, per_page = 10) # change per_page = 100 later 
    url = URI("https://api.themoviedb.org/3/tv/popular?language=en-US&page=#{page}&api_key=#{API_KEY}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = "application/json"

    response = http.request(request)

    if response.code == "200"
      series_data = JSON.parse(response.body)
      series = series_data["results"].take(per_page).map do |series|
        {
          nome_origem: series["original_name"],
          nome_pt: "",  # translate later...
          pais: series["origin_country"].join(", "),
          popularidade: series["popularity"],
          media_votacao: series["vote_average"],
          url_foto: series["poster_path"],
          sinopse: series["overview"]
        }
      end
      series
    else
      [] 
    end
  end

	def self.fetch_cast(series_id)
		url = URI("https://api.themoviedb.org/3/tv/#{series_id}/credits?language=en-US&api_key=#{API_KEY}")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Ner::HTTP::Get.new(url)
		request["accept"] = "application/json"

		response = http.request(request)

		if response.code == "200"
			cast_data = JSON.parse(response.body)
			cast = cast_data["results"].map do |cast|
				{
					nome_personagem: cast["character"],
					nome_real: cast["name"],
					url_foto: cast["profile_path"]
				}
			end
			cast
		else
				[]
		end
	end

end
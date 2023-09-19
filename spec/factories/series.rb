FactoryBot.define do
	factory :series do
		nome_pt { Faker::Lorem.word }
		nome_origem { Faker::Lorem.word }
		pais { Faker::Lorem.word }
		popularidade { rand(1..1000) }
		media_votacao { rand(0..10).to_f }
		sinopse { Faker::Lorem.sentences }
		url_foto { "/asgghasghas.jpg" }
		id_tmdb { rand(1..1000) }
	end
end
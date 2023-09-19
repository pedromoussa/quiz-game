FactoryBot.define do
	factory :character do
		nome_personagem { Faker::Name.name }
		nome_real { Faker::Name.name }
		url_foto { "/asghasghasgh.jpg" }
		series
	end
end
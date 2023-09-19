FactoryBot.define do
	factory :user_answer do
		mensagem { Faker::Lorem.word }
		user
		series_id { rand(1..10) }
		character_id { rand(1..10) }
	end
end
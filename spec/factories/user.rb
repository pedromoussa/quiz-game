FactoryBot.define do
	factory :user do
		username { Faker::Lorem.word }
		password { Faker::Alphanumeric.alpha(number: 10) }
		password_confirmation { password }
	end
end
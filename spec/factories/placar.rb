FactoryBot.define do
	factory :placar do
		user
		questoes { rand(1..10) }
		acertos { rand(0..10) }
		percentual { |placar| (placar.acertos.to_f / placar.questoes) * 100 unless placar.questoes.nil? }
	end
end
ActiveAdmin.register Quiz do
  config.clear_action_items!

	index do
		id_column
		column :character do |quiz|
			quiz.character.nome_personagem if quiz.character.present?
		end
		column :main_series do |quiz|
			quiz.main_series.nome_origem if quiz.main_series.present?
		end
		column :series do |quiz|
			quiz.series.map { |s| s.nome_origem }.join(", ") if quiz.series.any?
		end
	end

	collection_action :create_quiz, method: :post do

		character = Character.order("RAND()").first
		associated_series = Series.find_by(id: character.series_id)
		other_series = Series.where.not(id: associated_series.id).order("RAND()").limit(3)

  	quiz = Quiz.new(character: character, main_series: associated_series)
		
		other_series.each do |series|
			quiz.quiz_series.build(series: series)
		end

		quiz.save

	end

	action_item :create_quiz do
		link_to "Criar Quiz", "quizzes/create_quiz", method: :post
	end

end

class QuizSeries < ApplicationRecord
  belongs_to :quiz
  belongs_to :series
end

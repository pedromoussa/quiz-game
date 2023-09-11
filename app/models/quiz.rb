class Quiz < ApplicationRecord
  has_one :character
  has_many :user_answers
  has_many :quiz_series
  has_many :series, through: :quiz_series
  belongs_to :main_series, class_name: 'Series'
end

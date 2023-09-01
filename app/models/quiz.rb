class Quiz < ApplicationRecord
  has_many :user_answers
  belongs_to :series
  belongs_to :character
end

class Quiz < ApplicationRecord
  has_many :user_answers
  has_many :series
  has_one :character
end

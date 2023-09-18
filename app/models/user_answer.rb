class UserAnswer < ApplicationRecord
  belongs_to :user
  validates :mensagem, presence: true
  validates :series_id, presence: true
  validates :character_id, presence: true

end

class Character < ApplicationRecord
  belongs_to :series

  validates :nome_personagem, :nome_real, presence: true
end

class Placar < ApplicationRecord
	belongs_to :user

  validates :questoes, :acertos, :percentual, presence: true
end

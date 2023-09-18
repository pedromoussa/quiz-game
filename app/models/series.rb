class Series < ApplicationRecord
  has_many :character

  validates :nome_origem, :pais, :id_tmdb, presence: true
  validates :popularidade, presence: true
  validates :media_votacao, presence: true

  def to_s
    nome_origem
  end

  scope :popularidade_range, ->(min, max) {
    where(popularidade: min..max)
  }

  scope :media_votacao_range, ->(min, max) {
    where(media_votacao: min..max)
  }

end

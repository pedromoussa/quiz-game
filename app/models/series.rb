class Series < ApplicationRecord
  has_many :character 
  
  def to_s
    nome_origem
  end
end

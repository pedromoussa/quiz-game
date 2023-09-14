class Api::V1::QuestaoController < ApplicationController
  before_action :authorize_request

  # retorna nome/id de um personagem e nome/nome_original/id da serie correta e 3 outras
  def questao
    authorize! :questao, :user

    character = Character.order("RAND()").first
    associated_series = Series.find_by(id: character.series_id)
    other_series = Series.where.not(id: associated_series.id).order("RAND()").limit(3)    

    personagem = { "id" => character.id, "nome" => character.nome_personagem }
    serie_certa = { "id" => associated_series.id, "nome" => associated_series.nome_pt, "nome_original" => associated_series.nome_origem }
    serie_1 = { "id" => other_series[0].id, "nome" => other_series[0].nome_pt, "nome_original" => other_series[0].nome_origem }
    serie_2 = { "id" => other_series[1].id, "nome" => other_series[1].nome_pt, "nome_original" => other_series[1].nome_origem }
    serie_3 = { "id" => other_series[2].id, "nome" => other_series[2].nome_pt, "nome_original" => other_series[2].nome_origem }

    questao = { "personagem" => personagem, "series" => [serie_certa, serie_1, serie_2, serie_3] }
    
    render json: questao.to_json, status: 200

  end

end

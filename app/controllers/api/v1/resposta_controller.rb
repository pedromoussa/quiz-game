class Api::V1::RespostaController < ApplicationController
  before_action :authorize_request
  protect_from_forgery

  def resposta()

    character_id = params[:character_id]
    series_id = params[:series_id]
    
    token = request.headers["Authorization"].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]

    mensagem = ""
    character = Character.find(character_id)

    if series_id.to_s == character.series_id.to_s
      mensagem = "Parabens, você acertou!"
      status = 200
    else
      mensagem = "Não estou bravo, apenas decepcionado..."
      status = 422
    end

    token = request.headers["Authorization"].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]

    resposta = UserAnswer.create(user_id: user_id, character_id: character_id, series_id: series_id, mensagem: mensagem)
    
    render json: mensagem.to_json, status: status

  end

end

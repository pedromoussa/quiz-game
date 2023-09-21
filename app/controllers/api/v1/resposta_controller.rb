class Api::V1::RespostaController < ApplicationController
  before_action :authorize_request
  protect_from_forgery

  def resposta()
    authorize! :resposta, :user

    character_id = params[:personagem].split(' ')[1]
    series_id = params[:serie].split(' ')[1]
    
    if character_id == nil || series_id == nil
      render json: "missing params".to_json ,status: 500
      return
    end

    token = request.headers["Authorization"].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]

    mensagem = ""
    character = Character.find(character_id)

    if series_id.to_s == character.series_id.to_s
      mensagem = { :mensagem => "Parabens, você acertou!" }
      status = 200
    else
      mensagem = {:mensagem => "Não foi desta vez... A resposta correta era: #{Series.find(character[:series_id])}" }
      status = 422
    end

    token = request.headers["Authorization"].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]

    resposta = UserAnswer.create(user_id: user_id, character_id: character_id, series_id: series_id, mensagem: mensagem)
    
    render json: mensagem.to_json, status: status

  end

end

class Api::V1::RespostaController < ApplicationController

  # recebe id do personagem e id da serie
  # registra resposta do jogador e retorna o resultado
  def resposta(character_id, series_id)

    mensagem = ""
    character = Character.find(character_id)
    if series_id == character.series_id
      mensagem = "Parabens, você acertou!"
    else
      mensagem = "Não estou bravo, apenas decepcionado..."
    end

    # registrar resposta
    resposta = UserAnswer.create(character_id: character_id, series_id: series_id, mensagem: mensagem)
    
    render json: mensagem.to_json

  end

end

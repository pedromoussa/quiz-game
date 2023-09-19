class Api::V1::PlacarController < ApplicationController
  before_action :authorize_request

  def placar
    authorize! :placar, :user

    token = request.headers["Authorization"].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]

    respostas = UserAnswer.where(user_id: user_id)
    n_respostas = respostas.count()

    if n_respostas == 0
      err = "Não foi possível recuperar o placar, pois nenhuma questão foi respondida"
      render json: err.to_json, status: 500
      return
    end

    n_acertos = 0
    respostas.each do |resposta|
      if resposta.mensagem.start_with? "Parabens"
        n_acertos += 1
      end
    end

    n_erros = n_respostas - n_acertos
    if n_respostas > 0
      percentual = n_acertos.to_f/n_respostas*100
    end

    placar = Placar.find_or_create_by(user_id: user_id)
    placar.update(:questoes => n_respostas, :acertos => n_acertos, :percentual => percentual)

    res = {:questoes => placar.questoes, :acertos => placar.acertos, :percentual => placar.percentual}

    render json: res.to_json, status: 200

  end

end

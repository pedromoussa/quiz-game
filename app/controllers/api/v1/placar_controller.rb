class Api::V1::PlacarController < ApplicationController

  # retorna o placar de acertos do jogador
  
  # como fazer: criar ou atualizar placar do usuario baseado em quantas respostas existem associadas a ele
  # 1°: pegar todas respostas (= numero de perguntas respondidas)
  # 2°: verificar numero de acertos (contar mensagens de acerto)
  # 3°: calcular porcentagem de acertos
  # 4°: criar ou atualizar o placar utilizando os valores obtidos

  def placar

    # pegar id do jogador pela sessao (?)
    user_id = 1

    # encontrar respostas do jogador
    respostas = UserAnswer.where(user_id: user_id)
    n_respostas = respostas.count()

    # descobrir numero de acertos
    n_acertos = 0
    respostas.each do |resposta|
      if resposta.mensagem.start_with? "Parabens"
        n_acertos += 1
      end
    end

    # calcular numero de erros e percentual de acerto
    n_erros = n_respostas - n_acertos
    percentual = (n_acertos / n_respostas)

    # criar ou atualizar placar dp usuario
    placar = Placar.find_or_create_by(user_id: user_id)
    placar.update(:questoes => n_respostas, :acertos => n_acertos, :percentual => percentual)

    render json: placar.to_json

  end

end

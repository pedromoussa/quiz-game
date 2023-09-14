class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_a?(AdminUser)
      can :manage, :all
    end

    if user.is_a?(User)
      can :login, :user
      can :questao, :user
      can :placar, :user
      can :resposta, :user
    end
  end

end

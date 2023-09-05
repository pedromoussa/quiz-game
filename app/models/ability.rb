class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new   # visitante

    if user.admin?
      can :manage, :all
    else
      can :read, Quiz
    end
  end
end

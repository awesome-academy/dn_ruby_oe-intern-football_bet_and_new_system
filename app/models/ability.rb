class Ability
  include CanCan::Ability

  def initialize user
    can :read, [SoccerMatch, GoalResult]
    return unless user

    if user.admin?
      can :manage, :all
    else
      can [:read, :create], Currency, user: user
      can [:read, :create, :destroy], UserBet do |u|
        u.updated_at < u.bet.soccer_match.time
      end
      can :read, User, user: user
    end
  end
end

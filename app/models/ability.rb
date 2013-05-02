class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new   #for guest users

    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
    end
  end

end
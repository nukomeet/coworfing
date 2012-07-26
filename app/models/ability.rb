class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
      can :invite, User
    end

    if user.regular? 
      can :manage, Place, user_id: user.id
      can :create, Place
      can :read, Place
      can :submitted, Place, user_id: user.id

      can :invite, User

      can :update, User, :user_id => user.id 
      can :read, User

      can :read, PlaceRequest, booker_id: user.id 
      can :read, PlaceRequest, receiver_id: user.id 
      can :update, PlaceRequest, status: :pending, receiver_id: user.id
      can :create, PlaceRequest 

      can :see, :places
    end

    if user.guest?
      can :create, Demand 
      can :read, Place, public: true
      can :read, User, public: true
    end

  end
end

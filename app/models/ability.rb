class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new

    if user.admin?
      can :manage, :all
      can :invite, User
    end

    if user.regular? 
      can :manage, Place, :user_id => user.id
      can :create, Place
      can :read, Place
      can :submitted, Place, user_id: user.id

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

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

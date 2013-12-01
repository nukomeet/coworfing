class Ability
  include CanCan::Ability

  def initialize(user)
    # guest user (not logged in)
    user = user
    unless user
      user = User.new
      user.role = 'guest'
    end

    if user.admin?
      can :manage, :all
      can :invite, User
      can :edit_avatar, User, id: user.id
      can :read, :demands
    end

    if user.regular?
      can :manage, Place, owner_id: user.organization_ids, owner_type: 'Organization'
      can :manage, Place, owner_id: user.id, owner_type: 'User'

      can :read, Place, owner_type: nil
      can :read, Place, owner_type: 'User'


      can :create, Place
      can :submitted, Place, owner_id: user.id, owner_type: 'User'
      can :submitted, Place, owner_id: user.organization_ids, owner_type: 'Organization'

      can :update, Place, kind: :public

      can :invite, User
      can :read, User
      can :edit_avatar, User, id: user.id

      can :read, PlaceRequest, booker_id: user.id
      can :read, PlaceRequest, receiver_id: user.id
      can :update, PlaceRequest, status: :pending, receiver_id: user.id
      can :create, PlaceRequest

      can :read, Comment

      can :manage, Organization, id: user.admin_organization_ids
      can :read, Organization, id: user.regular_organization_ids

      can :manage, Membership, organization: { id: user.admin_organization_ids }
      can :read, Membership

      can :works, Checkin, user_id: user.id
      can :worked, Checkin, user_id: user.id
      can :uncheck, Checkin, user_id: user.id

      #can :see, :places
    end

    if user.guest?
      can :read, Place, owner_type: [ nil, 'User'], kind: [ :public, :business ]

      can :read, User, public: true
      can :read, Comment, place: { kind: :public }
    end

  end
end

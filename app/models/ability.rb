class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Everybody can read everything
    can :read, Package
    can :read, BlogPost


    # Admins can do anything
    if user.admin?
      can :manage, :all
    end

    # A user can manage a package if it belongs to their git user
    # jimrhoskins/foobar can be edited by jimrhoskins regardles of creator
    can :update, Package do |package|
      user.id && (package.owner_id == user.id || package.submitter_id == user.id)
    end

    # Authenticated users
    if user.id
      can :create, Package
    end

  end
end

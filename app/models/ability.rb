class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, [Restaurant, Review]

    # admin
    if user.admin?
      can :manage, :all
    
    # restaurateur
    elsif user.restaurateur?

      can :manage, Dish do |dish|
        dish.try(:owner) == user
      end

      can :manage, Menu do |menu|
        menu.try(:owner) == user
      end

      can :manage, Deliverability do |deliverability|
        deliverability.try(:owner) == user
      end

      can :manage, BusinessHour do |business_hour|
        business_hour.try(:owner) == user
      end

      can :manage, Restaurant do |restaurant|
        restaurant.try(:owner) == user
      end

      can [:accept, :reject], Order do |order|
        order.try(:restaurant).try(:owner) == user
      end

      can :restaurateur, User

      can :report, User
    end

    can :manage, LineItem # Is this ok?
    can :manage, Cart # Potential security problem

    can :read, Order, user_id: user.id
    can :read, Address, user_id: user.id

    # any user
    can :create, Order
    can :create, Address
    can :create, Review # Potential security problem

    can :update, User do |some_user|
      user == some_user
    end

    can :show, User do |some_user|
      user == some_user
    end

    can :partner, User

    can :select, District

    can :search, Restaurant

    can :rate, Restaurant

  end
end

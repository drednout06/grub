class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
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
        deliverability.try(:restaurant) == user.restaurant
      end

      can [:update, :operate, :get_orders, :stats], Restaurant do |restaurant|
        restaurant.try(:owner) == user
      end

      can :create, Restaurant

      can [:accept, :reject], Order do |order|
        order.try(:restaurant).try(:owner) == user
      end

      can :restaurateur, User

    # user
    end

    can :create, Order

    can :create, Address   

    can :update, User do |some_user|
      user == some_user
    end

    can :rate, Restaurant do |restaurant|
      true # if the user has ever ordered from the restaurant
    end

    can :manage, LineItem # Is this ok?

    can :manage, Cart # Potential security problem

    can :manage, Address do |address|
      address.try(:user) == user
    end
  end
end

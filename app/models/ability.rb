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
        dish.try(:restaurant) == user.restaurant
      end

      can :manage, Menu do |menu|
        menu.try(:restaurant) == user.restaurant
      end

      can :manage, Deliverability do |deliverability|
        deliverability.try(:restaurant) == user.restaurant
      end

      can :update, Restaurant do |restaurant|
        restaurant.try(:user) == user
      end

      can :operate, Restaurant do |restaurant|
        restaurant.try(:user) == user
      end      

    # user
    else
      can :create, Order

      can :update, User do |some_user|
        user == some_user
      end

      can :rate, Restaurant do |restaurant|
        true # if the user has ever ordered from the restaurant
      end

      can :manage, LineItem do |line_item|
        line_item.try(:user) == user
      end

      can :manage, Cart do |cart|
        cart.try(:user) == user
      end

      can :manage, Address do |address|
        address.try(:user) == user
      end

    end
    #
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

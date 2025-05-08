# frozen_string_literal: true

class Ability
    include CanCan::Ability
  
    def initialize(user)
      if user.is_admin?
        can :manage, :all
      elsif user.is_organizer?
        can :manage, Event
        can :read, Venue
        can :read, EventType
        can :manage, EventBooking
        can :manage, DiscountCode
        can :read, DiscountCode
        can :read, Event
      elsif user.is_user?
        can :manage, EventBooking
        can :manage, Payment
        can :read, Event
        can :read, Venue
        can :read, EventType
        can :manage, DiscountCode
      end
    end
  end
  
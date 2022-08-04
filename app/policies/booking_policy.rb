class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    @bookings = policy_scope(Booking).order(created_at: :asc)
  end

  def show?
    true
  end
end

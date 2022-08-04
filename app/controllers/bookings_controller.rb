class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]
  before_action :authenticate_user!, only: %i[index show]

  def index
    @bookings = policy_scope(Booking.where("user_id = #{current_user.id}").order(created_at: :asc))
  end

  def show
    authorize @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :minion_id, :status)
  end
end

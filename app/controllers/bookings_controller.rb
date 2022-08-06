class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]
  before_action :authenticate_user!, only: %i[index show create]
  def index
    @bookings = policy_scope(Booking.where("user_id = #{current_user.id}").order(created_at: :asc))
  end

  def show
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.minion_id = @booking.minion.id
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
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

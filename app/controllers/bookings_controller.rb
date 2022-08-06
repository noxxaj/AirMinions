class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]
  before_action :authenticate_user!, only: %i[index show create]
  def index
    @bookings = policy_scope(Booking.where("user_id = #{current_user.id}").order(created_at: :asc))

    @owned_minions = policy_scope(Minion.where("user_id = #{current_user.id}"))

    @hosted_bookings = @owned_minions.map do |owned_minion|
      Booking.where("minion_id = #{owned_minion.id}")
    end
    @hosted_bookings.flatten!
    # bookings containing a minion which you (the user) host
    # find bookings where
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

  def edit
    # bookings that the user hosts
    @bookings = Booking.where("user_id = #{current_user.id}").order(created_at: :asc)
    # bookings the user(host) is related to

  end

  def update

  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :minion_id, :status)
  end
end

class MinionsController < ApplicationController
  before_action :set_minion, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[edit update create]

  def index
    if params[:query].present?
      @minions = policy_scope(Minion.search_by_name_and_skills(params[:query])).order(created_at: :asc)
    else
      @minions = policy_scope(Minion).order(created_at: :asc)
    end
    @markers = @minions.geocoded.map do |minion|
      {
        lat: minion.latitude,
        lng: minion.longitude,
        info_window: render_to_string(partial: "info_window", locals: { minion: minion }),
        image_url: helpers.asset_url("minion.png")
      }
    end
  end

  def create
    @minion = Minion.new(minion_params)
    @minion.user_id = current_user.id
    if @minion.save
      redirect_to minions_path
    else
      render :new
    end
    authorize @minion
  end

  def show
    @booking = Booking.new
    authorize @minion
    authorize @booking
  end

  def update
    # raise
    if @minion.update!(minion_params)
      redirect_to minion_path(@minion)
    else
      render :edit
    end
    authorize @minion
  end

  def edit
    authorize @minion
  end

  def destroy
    @minion.destroy
    redirect_to minions_path
    authorize @minion
  end

  def new
    @minion = Minion.new
    authorize @minion
  end

  private

  def set_minion
    @minion = Minion.find(params[:id])
  end

  def minion_params
    params.require(:minion).permit(:name, :description, :skills, :price_per_day, :user_id, :photo, :address)
  end
end

class MinionsController < ApplicationController
  before_action :set_minion, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[edit update create]
  def index
    @minions = policy_scope(Minion).order(created_at: :asc)
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

  def search
    @sql_query = "minions.name @@ :query"
    @wanted_minion = Minion.where(@sql_query, query: "%#{params[:query]}%")
    # @wanted_minion = Minion.where(name: params[:name]).first
    redirect_to minion_path(@wanted_minion)
    authorize @wanted_minion
  end

  def show
    @booking = Booking.new
    authorize @minion
    authorize @booking
  end

  def update
    @minion.update(minion_params)
    redirect_to minion_path(@minion)
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
    @sql_query = "minions.name @@ :query"
    @minion = Minion.where(@sql_query, query: "%#{params[:query]}%")
  end

  def minion_params
    params.require(:minion).permit(:name, :description, :skills, :price_per_day, :user_id, :photo, :address)
  end
end

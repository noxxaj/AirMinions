class MinionsController < ApplicationController
  before_action :set_minion, only: %i[show]
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
    @wanted_minion = Minion.where(name: params[:name]).first
    redirect_to minion_path(@wanted_minion)
    authorize @wanted_minion
  end

  def show
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
    params.require(:minion).permit(:name, :description, :skills, :price_per_day, :user_id, :photo)
  end
end

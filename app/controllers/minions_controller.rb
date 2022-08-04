class MinionsController < ApplicationController
  before_action :set_minion, only: %i[show]
  def index
    @minions = policy_scope(Minion).order(created_at: :asc)
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

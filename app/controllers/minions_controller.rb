class MinionsController < ApplicationController
  before_action :set_minion, only: %i[show]
  def index
    @minions = policy_scope(Minion).order(created_at: :desc)
  end

  def create
    @minion = Minion.new(minion_params)
    if @minion.save
      redirect_to minions_path
    else
      render :new
    end
  end

  def show
    authorize @minion
  end

  def new
    @minion = Minion.new
  end

  private

  def set_minion
    @minion = Minion.find(params[:id])
  end

  def minion_params
    params.require(:minion, :user_id).permit(:name, :skills, :price_per_day)
  end
end

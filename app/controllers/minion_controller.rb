class MinionController < ApplicationController
  # before_action :set_minion, only: [:edit, :show]
  def index
    @minions = Minion.all
  end

  def create
    @minion = Minion.new(minion_params)
    if @minion.save
      redirect_to minions_path
    # else
      # render :new
    end
  end

  private

  def set_minion
    @minion = Minion.find(params[:id])
  end

  def minion_params
    params.require(:minion).permit(:name, :skills)
  end
end

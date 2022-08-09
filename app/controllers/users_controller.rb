class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def show
    @owned_minions = policy_scope(Minion.where("user_id = #{current_user.id}"))
    @user = current_user
    authorize @user
  end
end

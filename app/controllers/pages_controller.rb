class PagesController < ApplicationController
  def home
    @minions = Minion.all
  end
end

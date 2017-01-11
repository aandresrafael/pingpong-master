class HomeController < ApplicationController
  def index
    @users = User.leaderborad
  end

  def history
  end

  def log
  end
end

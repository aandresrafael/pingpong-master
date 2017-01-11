class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id

    if @game.save
      flash[:notice] = "Game was created successfully."
      redirect_to root_path
    else
      flash[:error] = "Game was not crated due to the next errors:"
      render :new
    end
  end

  def history
    @games = current_user.games.all
  end

  def game_params
    params.require(:game).permit(:opponent_id, :date_played, :user_score, :opponent_score)
  end
end

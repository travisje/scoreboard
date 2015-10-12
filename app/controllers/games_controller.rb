class GamesController < ApplicationController
  
  def index
    Game.buildgames
    @games = Game.all
  end

end
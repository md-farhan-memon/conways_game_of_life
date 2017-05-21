class WorldController < ApplicationController
  # before_action :set_population, only: [:playground]
  before_action :init, only: [:index, :start, :clear]
  def home
  end

  def index
    @@life = World.new(@size)
  end

  def start
    @@life.load game_params[:cells].values.map{ |arr| arr.map(&:to_i) } if game_params[:load] == 'true'
    @grid = @@life.tick
  end

  def clear
    @@life = World.new(@size)
  end

  private

  def game_params
    game_params = params.permit(:load)
    game_params[:cells] = params[:cells].as_json
    game_params.permit!
  end

  def init
    @size = 12
  end
end
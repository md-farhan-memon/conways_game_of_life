class WorldController < ApplicationController
  include OverriddenMethods
  before_action :set_grid, only: %i[playground start clear]
  before_action :initialize_grid, only: %i[clear playground]
  before_action :set_population, only: %i[playground]

  def home; end

  def clear; end

  def playground
    @grid = @@life.grid
  end

  def start
    @@life.load(game_params[:cells].each_value.map { |arr| arr.map(&:to_i) }) if game_params[:load].true?
    @grid = @@life.tick
  end

  private

  def game_params
    game_params = params.permit(:load)
    game_params[:cells] = params[:cells].as_json
    game_params.permit!
  end

  def set_grid
    @size = GRID_SIZE
  end

  def initialize_grid
    @@life = World.new(@size)
  end

  def set_population
    return unless params[:pattern] && (pattern = PATTERNS[params[:pattern]]).present?
    @@life.load(pattern.map { |arr| arr.map(&:to_i) })
  end
end

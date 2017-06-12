class World
  include OverriddenMethods
  attr_accessor :grid, :grid_size

  def initialize(size)
    @grid_size = size
    @grid = Array.new(grid_size) { Array.new(grid_size, dead) }
  end

  def load(cells)
    cells.each { |x, y| grid[x][y] = born }
  end

  def tick
    @grid = @grid.map.with_index do |column, x|
              column.map.with_index do |cell, y|
                if cell.dead?
                  should_take_birth?(x, y) ? born : dead
                elsif cell.alive?
                  should_live?(x, y) ? lives : dies
                end
              end
            end
  end

  def dead
    0
  end

  def born
    1
  end

  alias dies dead
  alias lives born
  private :dies, :dead, :lives, :born

  private

  def should_take_birth?(x, y)
    count_neighbors([x, y]) == 3
  end

  def should_live?(x, y)
    count_neighbors([x, y]).between?(2, 3)
  end

  def count_neighbors(cell)
    NEIGHBOURS.values.map { |neighbor| cell.zip(neighbor).map { |v| v.reduce(:+) } }.select do |neighbor|
      neighbor = neighbor.map { |n| n.negative? ? (grid_size - born) : n > (grid_size - 1) ? dead : n }
      grid[neighbor.first][neighbor.last].nonzero?
    end.length
  end
end

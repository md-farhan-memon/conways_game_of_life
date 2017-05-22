class World
  include OverriddenMethods
  attr_accessor :grid, :grid_size

  def initialize(size)
    @grid_size = size
    @grid = Array.new(grid_size) { Array.new(grid_size, dead) }
  end

  def load(cells)
    cells.each { |x, y| grid[x][y] = 1 }
  end

  def tick
    @grid = @grid.map.with_index do |column, x|
              column.map.with_index do |cell, y|
                if cell.dead?
                  count_neighbors([x, y]) == 3 ? born : dead
                else
                  count_neighbors([x, y]).between?(2, 3) ? born : dead
                end
              end
            end
  end

  private

  def count_neighbors(cell)
    NEIGHBOURS.values.map { |neighbor| cell.zip(neighbor).map { |v| v.reduce(:+) } }.select do |neighbor|
      neighbor = neighbor.map { |n| n.negative? ? (grid_size - born) : n > (grid_size - 1) ? dead : n }
      grid[neighbor.first][neighbor.last].nonzero?
    end.length
  end

  def dead
    0
  end

  def born
    1
  end

end
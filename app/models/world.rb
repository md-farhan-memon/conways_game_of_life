class World
  attr_accessor :grid, :grid_size

  def initialize(size)
    @grid_size = size
    @grid = Array.new(grid_size) { Array.new(grid_size, 0) }
  end

  def load(cells)
    cells.each { |x, y| grid[x][y] = 1 }
  end

  def tick
    @grid =
    @grid.map.with_index do |column, x|
      column.map.with_index do |cell, y|
        if cell.zero?
          count_neighbors([x,y]) == 3 ? 1 : 0
        else
          count_neighbors([x,y]).between?(2,3) ? 1 : 0
        end
      end
    end
  end

  def count_neighbors(cell)
    NEIGHBOURS.values.map { |neighbor| cell.zip(neighbor).map{ |v| v.reduce(:+) } }.select do |neighbor|
      neighbor = neighbor.map { |n| n < 0 ? (grid_size - 1) : n > (grid_size - 1) ? 0 : n }
      grid[neighbor.first][neighbor.last].nonzero?
    end.length
  end
end
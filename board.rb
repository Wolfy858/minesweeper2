class Board
  attr_reader :grid

  def self.standard_grid
    Array.new(9) { Array.new(9)}
  end

  def initialize(grid = Board.standard_grid)
    @grid = grid
    setup_tiles
    populate_bombs(10)
  end

  def setup_tiles
    @grid.each_with_index do |row, i|
      row.each_with_index do |el, j|
        self[i, j] = Tile.new(self, [i, j])
      end
    end
  end

  def populate_bombs(num)
    bomb_count = 0
    until bomb_count == num
      current_tile = @grid.sample.sample
      unless current_tile.bombed?
        current_tile.bomb
        bomb_count += 1
      end
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col]= value
  end

  def render
    @grid.each do |row|
      row.each {|el| print el.to_s + " "}
      puts
    end
  end

end

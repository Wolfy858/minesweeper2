class Tile
  attr_reader :revealed

  DELTAS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [-1, -1]
  ]

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bombed = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def bombed?
    @bombed
  end

  def neighbors
    adjacent_coords = deltas.map do |(dx, dy)|
      [pos[0] + dx, pos[0] + dy]
    end.select do |row, col|
      [row, col].all? {|coord| coord.between?(0, @board.length)}
    end
    adjacent_coords.map {|pos| @board[pos]}
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each {|neighbor| count += 1 if neighbor.bombed? }
  end

end

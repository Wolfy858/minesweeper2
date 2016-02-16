require './board'

class Tile
  attr_reader :revealed, :flagged

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
    @flagged = false
  end

  def reveal
    return self if revealed
    @revealed = true
    if neighbor_bomb_count == 0
      neighbors.each {|neighbor| neighbor.reveal unless neighbor.flagged}
    end
  end


  def bombed?
    @bombed
  end

  def bomb
    @bombed = true
  end

  def flag_unflag
    @flagged ? @flagged = false : @flagged = true
  end

  def neighbors
    adjacent_coords = DELTAS.map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end.select do |row, col|
      [row, col].all? {|coord| coord.between?(0, @board.grid.length - 1)}
    end
    adjacent_coords.map {|pos| @board[*pos]}
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each {|neighbor| count += 1 if neighbor.bombed? }
    count
  end

  def inspect
    # {
    #   :pos => @pos,
    #   :bombed => @bombed,
    #   :revealed => @revealed
    # }
    @bombed
  end

  def to_s
    if revealed
      neighbor_bomb_count > 0 ? neighbor_bomb_count.to_s : " "
    elsif flagged
      "F"
    else
      "_"
    end
  end



end

# b = Board.new
# b[0, 0].reveal
# b[1, 1].reveal
# b[2, 2].reveal
# b[3, 3].reveal

# p b.render
# p b[0, 0].neighbors
# p b[3, 3].neighbors

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    until over?
      play_turn
    end
    puts "You win!"
  end

  def play_turn
    board.render
    input = get_input
    if input[0] == "F"
      board[input[1]].flag_unflag
    elsif input[0] == "R"
      board[input[1]].reveal
    else
      puts "Invalid input"
    end
  end

end

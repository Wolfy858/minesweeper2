require './tile'
require './board'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    until over?
      play_turn
    end
    puts board.won? ? "You win!" : "You lose!"
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

  def get_input
    puts "Enter Flag(F) or Reveal(R), followed by coordinates 'F 3,3'"
    input = gets.chomp.split(" ")
    return_value = [input[0]]
    coords = input.split(",").map {|char| char.to_i}
    return_value << coords
    return_value
  end

  def over?
    board.won? || board.lost?
  end

end


if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end

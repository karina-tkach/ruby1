require_relative("board.rb")

class Game
  def initialize
    @board = Board.new
    @current_player = "X"
  end

  def play
    puts "Welcome to Tic-Tac-Toe!"
    @board.display

    loop do
      puts "Player #{@current_player}, enter your move as 'row col' (0-2):"

      row, col = gets.chomp.split.map(&:to_i)

      if @board.place_mark(row, col, @current_player)
        @board.display

        if @board.winning_line?(@current_player)
          puts "Player #{@current_player} wins!"
          break
        elsif @board.full?
          puts "It's a draw!"
          break
        else
          switch_player
        end

      else
        puts "Invalid move! Try again."
      end
    end
  end

  private

  def switch_player
    @current_player = @current_player == "X" ? "Y" : "X"
  end
end
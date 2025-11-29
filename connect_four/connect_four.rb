class ConnectFour
  attr_reader :board, :current_player

  ROWS = 6
  COLS = 7

  def initialize
    @board = Array.new(ROWS) { Array.new(COLS, nil) }
    @current_player = 'X'
  end

  # Check if a column is valid (within bounds and not full)
  def valid_move?(col)
    col.between?(0, COLS - 1) && @board[0][col].nil?
  end

  # Drop a piece into a column
  def drop_piece(col, mark)
    return false unless valid_move?(col)

    row = ROWS - 1
    row -= 1 while @board[row][col] && row >= 0
    @board[row][col] = mark
    true
  end

  # Check if the board is full
  def full?
    @board.flatten.none?(&:nil?)
  end

  # Switch current player
  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  # Detect if a player has a winning line
  def winning_line?(mark)
    horizontal_win?(mark) || vertical_win?(mark) || diagonal_win?(mark)
  end

  private

  # Horizontal check
  def horizontal_win?(mark)
    @board.any? do |row|
      row.each_cons(4).any? { |slice| slice.all? { |cell| cell == mark } }
    end
  end

  # Vertical check
  def vertical_win?(mark)
    @board.transpose.any? do |col|
      col.each_cons(4).any? { |slice| slice.all? { |cell| cell == mark } }
    end
  end

  # Diagonal check (both directions)
  def diagonal_win?(mark)
    # bottom-left to top-right
    (0..ROWS-4).any? do |r|
      (0..COLS-4).any? do |c|
        4.times.all? { |i| @board[r+i][c+i] == mark }
      end
    end ||
    # top-left to bottom-right
    (3..ROWS-1).any? do |r|
      (0..COLS-4).any? do |c|
        4.times.all? { |i| @board[r-i][c+i] == mark }
      end
    end
  end
end

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, " ") }
  end

  def display
    puts
    puts " #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]} "
    puts "---+---+---"
    puts " #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]} "
    puts "---+---+---"
    puts " #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]} "
    puts
  end

  def place_mark(row, col, mark)
    return false unless valid_move?(row, col)

    @grid[row][col] = mark
    true
  end

  def valid_move?(row, col)
    row.between?(0,2) && col.between?(0,2) && @grid[row][col] == " "
  end

  def winning_line?(mark)
    rows = @grid
    cols = @grid.transpose
    diags = [
      [@grid[0][0], @grid[1][1], @grid[2][2]],
      [@grid[0][2], @grid[1][1], @grid[2][0]]
    ]

    (rows + cols + diags).any? { |line| line.all?(mark) }
  end

  def full?
    @grid.flatten.none?(" ")
  end
end
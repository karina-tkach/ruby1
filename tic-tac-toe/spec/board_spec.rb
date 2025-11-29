require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#place_mark' do
    it 'places a mark in an empty cell' do
      expect(board.place_mark(0,0,'X')).to be true
      expect(board.grid[0][0]).to eq('X')
    end

    it 'does not place a mark in an occupied cell' do
      board.place_mark(0,0,'X')
      expect(board.place_mark(0,0,'O')).to be false
    end
  end

  describe '#valid_move?' do
    it 'returns true for empty cell within bounds' do
      expect(board.valid_move?(1,1)).to be true
    end

    it 'returns false for out-of-bounds cells' do
      expect(board.valid_move?(3,3)).to be false
      expect(board.valid_move?(-1,0)).to be false
    end
  end

  describe '#winning_line?' do
    it 'detects a winning row' do
      board.place_mark(0,0,'X')
      board.place_mark(0,1,'X')
      board.place_mark(0,2,'X')
      expect(board.winning_line?('X')).to be true
    end

    it 'detects a winning column' do
      board.place_mark(0,0,'O')
      board.place_mark(1,0,'O')
      board.place_mark(2,0,'O')
      expect(board.winning_line?('O')).to be true
    end

    it 'detects a winning diagonal' do
      board.place_mark(0,0,'X')
      board.place_mark(1,1,'X')
      board.place_mark(2,2,'X')
      expect(board.winning_line?('X')).to be true
    end
  end

  describe '#full?' do
    it 'returns false for empty board' do
      expect(board.full?).to be false
    end

    it 'returns true for full board' do
      3.times { |i| 3.times { |j| board.place_mark(i,j,'X') } }
      expect(board.full?).to be true
    end
  end
end

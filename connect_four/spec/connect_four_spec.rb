require_relative '../connect_four'

RSpec.describe ConnectFour do
  let(:game) { ConnectFour.new }

  describe 'board initialization' do
    it 'creates a 6x7 empty board' do
      expect(game.board.size).to eq(6)
      expect(game.board.all? { |row| row.size == 7 }).to be true
      expect(game.board.flatten.all? { |cell| cell.nil? }).to be true
    end
  end

  describe '#valid_move?' do
    it 'allows placing in a column that is not full' do
      expect(game.valid_move?(0)).to be true
    end

    it 'rejects placing in a full column' do
      6.times { game.drop_piece(0, 'X') }
      expect(game.valid_move?(0)).to be false
    end

    it 'rejects placing in an invalid column' do
      expect(game.valid_move?(-1)).to be false
      expect(game.valid_move?(7)).to be false
    end
  end

  describe '#drop_piece' do
    it 'drops a piece to the lowest empty spot in a column' do
      game.drop_piece(0, 'X')
      expect(game.board[5][0]).to eq('X')
      game.drop_piece(0, 'O')
      expect(game.board[4][0]).to eq('O')
    end
  end

  describe '#winning_line?' do
    context 'horizontal win' do
      it 'detects a horizontal win' do
        (0..3).each { |c| game.drop_piece(c, 'X') }
        expect(game.winning_line?('X')).to be true
      end
    end

    context 'vertical win' do
      it 'detects a vertical win' do
        4.times { game.drop_piece(0, 'O') }
        expect(game.winning_line?('O')).to be true
      end
    end

    context 'diagonal win' do
      it 'detects a diagonal win' do
        # Build a diagonal from bottom left to top right
        game.drop_piece(0, 'X')
        game.drop_piece(1, 'O'); game.drop_piece(1, 'X')
        game.drop_piece(2, 'O'); game.drop_piece(2, 'O'); game.drop_piece(2, 'X')
        game.drop_piece(3, 'O'); game.drop_piece(3, 'O'); game.drop_piece(3, 'O'); game.drop_piece(3, 'X')
        expect(game.winning_line?('X')).to be true
      end
    end
  end

  describe '#full?' do
    it 'returns false for empty board' do
      expect(game.full?).to be false
    end

    it 'returns true for full board' do
      6.times do |r|
        7.times do |c|
          game.drop_piece(c, 'X')
        end
      end
      expect(game.full?).to be true
    end
  end

  describe 'switching players' do
    it 'alternates current player' do
      expect { game.switch_player }.to change { game.current_player }.from('X').to('O')
      expect { game.switch_player }.to change { game.current_player }.from('O').to('X')
    end
  end
end

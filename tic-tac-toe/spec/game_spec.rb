require_relative '../lib/game'
require_relative '../lib/board'

RSpec.describe Game do
  let(:game) { Game.new }

  describe 'switching players' do
    it 'switches from X to Y and back' do
      expect { game.send(:switch_player) }.to change { game.instance_variable_get(:@current_player) }.from('X').to('Y')
      expect { game.send(:switch_player) }.to change { game.instance_variable_get(:@current_player) }.from('Y').to('X')
    end
  end
end

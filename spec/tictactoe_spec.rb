# frozen_string_literal: true

require 'rspec'

class TicTacToe
  def initialize
    @current_player = 'X'
  end

  attr_reader :current_player

  def play
    @current_player = if @current_player == 'X'
                        'O'
                      else
                        'X'
                      end
  end

  def winner
    ''
  end
end

describe 'TicTacToeGame' do
  game = TicTacToe.new
  context 'when game starts' do
    it 'X should make the first move' do
      current_player = game.current_player

      expect(current_player).to eq('X')
    end
  end
  context 'when first player, X, has played' do
    it 'O should make the second move' do
      game.play

      current_player = game.current_player

      expect(current_player).to eq('O')
    end
  end
  it 'should allow players to alternate' do
    game.play
    game.play

    current_player = game.current_player

    expect(current_player).to eq('X')
  end
  context 'when a game is ongoing' do
    it 'should not allow a players to play on an already played square' do
      game.play
      game.play

      winner = game.winner

      expect { winner }.to raise StandardError, 'Cannot play a square that has already been played'
    end
  end
end

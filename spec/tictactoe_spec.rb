# frozen_string_literal: true


class TicTacToe
  attr_reader :current_player

  def initialize(board = [])
    @current_player = 'X'
    @board = board
  end

  def play(position)
    raise StandardError, "Can't play on already played position" if @board[position]
    @board[position] = @current_player
     if @current_player == 'X'
       @current_player = 'O'
     else
       @current_player = 'X'
     end
  end

  def winner
    if @board[0] == 'O' && @board[1] == 'O' && @board[1] == 'O' && @board[2] == 'O'
      return 'O'
    end
    'X'
  end
end

describe 'TicTacToeGame' do
  before :each do
    @game = TicTacToe.new
  end

  context 'when game starts' do
    it 'X should make the first move' do
      current_player = @game.current_player

      expect(current_player).to eq('X')
    end
  end

  it 'should allow players to alternate' do
    @game.play(0)
    @game.play(1)

    current_player = @game.current_player

    expect(current_player).to eq('X')
  end
  it 'should not allow players to play on already played squares' do
    @game.play(0)

    expect { @game.play(0) }.to raise_error StandardError, "Can't play on already played position"
  end

  it 'should make X the winner with 3 marks in a horizontal row' do
    @game.play(0)
    @game.play(3)
    @game.play(1)
    @game.play(4)
    @game.play(2)

    winner = @game.winner

    expect(winner).to eq('X')
  end

  it 'should make O the winner with 3 marks in a horizontal row' do
    @game.play(4)
    @game.play(0)
    @game.play(6)
    @game.play(1)
    @game.play(3)
    @game.play(2)

    winner = @game.winner

    expect(winner).to eq('O')
  end
end

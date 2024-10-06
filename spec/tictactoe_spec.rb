# frozen_string_literal: true


class TicTacToe
  attr_reader :current_player

  def initialize(board = [])
    @current_player = 'X'
    @board = board
    @array_of_winning_lines = [
      [0, 1, 2],
    ]
  end

  def play(position)
    raise StandardError, "Can't play on already played position" if @board[position]
    @board[position] = @current_player
    switch_player
  end

  def winner
    @array_of_winning_lines.each do |winning_line|
      if (@board[winning_line[0]] == @board[0]) &&
        (@board[winning_line[1]] == @board[1]) &&
        (@board[winning_line[1]] == @board[1]) &&
        (@board[winning_line[2]] == @board[2])
        return @board[winning_line[0]]
      end
    end
  end

  private

  def switch_player
    if @current_player == 'X'
      @current_player = 'O'
    else
      @current_player = 'X'
    end
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

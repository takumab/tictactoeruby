# frozen_string_literal: true

module Position
  TOPLEFT = 0
  TOPMIDDLE = 1
  TOPRIGHT = 2
  CENTERLEFT = 3
  CENTER = 4
  CENTERRIGHT = 5
  BOTTOMLEFT = 6
  BOTTOMMIDDLE = 7
  BOTTOMRIGHT = 8
end

module Player
  X = 'X'
  O = 'O'
end

class TicTacToe
  attr_reader :current_player

  def initialize(board = [])
    @current_player = Player::X
    @board = board
    @array_of_winning_lines = [
      [Position::TOPLEFT, Position::TOPMIDDLE, Position::TOPRIGHT],
      [Position::CENTERLEFT, Position::CENTER, Position::CENTERRIGHT],
      [Position::BOTTOMLEFT, Position::BOTTOMMIDDLE, Position::BOTTOMRIGHT]
    ]
  end

  def play(position)
    is_position_taken?(position)
    @board[position] = @current_player
    switch_player
  end

  def winner
    @array_of_winning_lines.each do |winning_line|
      if (@board[winning_line[0]] == @board[winning_line[1]]) &&
         (@board[winning_line[1]] == @board[winning_line[2]])
        return @board[winning_line[0]]
      end
    end
  end

  private

  def switch_player
    @current_player = if @current_player == Player::X
                        Player::O
                      else
                        Player::X
                      end
  end

  def is_position_taken?(position)
    raise StandardError, "Can't play on already played position" unless @board[position].nil?
  end
end

describe 'TicTacToeGame' do
  before :each do
    @game = TicTacToe.new
  end


  context 'when game starts' do
    it 'X should make the first move' do
      current_player = @game.current_player

      expect(current_player).to eq(Player::X)
    end
  end

  it 'should allow players to alternate' do
    @game.play(0)
    @game.play(1)

    current_player = @game.current_player

    expect(current_player).to eq(Player::X)
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

    expect(winner).to eq(Player::X)
  end

  it 'should make O the winner with 3 marks in a horizontal row' do
    @game.play(4)
    @game.play(0)
    @game.play(6)
    @game.play(1)
    @game.play(3)
    @game.play(2)

    winner = @game.winner

    expect(winner).to eq(Player::O)
  end

  it 'should make X the winner with 3 marks in second horizontal row' do
    @game.play(3)
    @game.play(0)
    @game.play(4)
    @game.play(1)
    @game.play(5)

    winner = @game.winner

    expect(winner).to eq(Player::X)
  end

  it 'should make O the winner with 3 marks in second horizontal row' do
    @game.play(0)
    @game.play(3)
    @game.play(1)
    @game.play(4)
    @game.play(6)
    @game.play(5)

    winner = @game.winner

    expect(winner).to eq(Player::O)
  end

  it 'should make X the winner with 3 marks in third horizontal row' do
    @game.play(6)
    @game.play(0)
    @game.play(7)
    @game.play(4)
    @game.play(8)

    winner = @game.winner

    expect(winner).to eq(Player::X)
  end

  it 'should make O the winner with 3 marks in third horizontal row' do
    @game.play(0)
    @game.play(6)
    @game.play(4)
    @game.play(7)
    @game.play(2)
    @game.play(8)

    winner = @game.winner

    expect(winner).to eq(Player::O)
  end
end

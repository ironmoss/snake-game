require_relative 'keypress'
require_relative 'board'
require_relative 'player'
require_relative 'bittle'
require_relative 'tailpiece'

class Game

  attr_reader :board, :player, :bittle

  def initialize
    @board = Board.new
    @player = Player.new(@board)
    @bittle = Bittle.new(@board)
    @board.drawBoard(@player, @bittle)
    play_game
  end

  def play_game
    while @player.is_on_board?(@board) && !@player.hit_tail?
      STDIN.echo = false
      input = STDIN.getc.chr

      case input
      when "w"
        @player.move_up
      when "s"
        @player.move_down
      when "d"
        @player.move_right
      when "a"
        @player.move_left
      end

      @board.drawBoard(@player, @bittle)

      if @player.got_bittle?(@bittle)
        @player.grow
        @bittle = Bittle.new(@board)
      end

    end

    puts "You collided with the wall and died." if !@player.is_on_board?(@board)
    puts "You collided with your tail and died." if @player.hit_tail?

  end

end

Game.new

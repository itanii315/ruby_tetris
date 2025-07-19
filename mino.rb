require "./keyboard"

class Mino
  I = [
    [0, 0, 0, 0],
    [1, 1, 1, 1],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ]
  J = [
    [1, 0, 0],
    [1, 1, 1],
    [0, 0, 0],
  ]
  L = [
    [0, 0, 1],
    [1, 1, 1],
    [0, 0, 0],
  ]
  Z = [
    [1, 1, 0],
    [0, 1, 1],
    [0, 0, 0],
  ]
  S = [
    [0, 1, 1],
    [1, 1, 0],
    [0, 0, 0],
  ]
  T = [
    [0, 1, 0],
    [1, 1, 1],
    [0, 0, 0],
  ]
  O = [
    [1, 1],
    [1, 1],
  ]
  MINOS = [nil, I, J, L, Z, S, T, O]

  attr_accessor :blocks, :x, :y

  def initialize(num, player)
    @color_num = num
    init_blocks
    @player = player
    reset
  end

  def reset
    @x = 3
    @y = 0
    init_blocks
  end

  def update
    move(-1, 0) if Keyboard.key_down?(Gosu::KB_LEFT)
    move(1, 0) if Keyboard.key_down?(Gosu::KB_RIGHT)
    move(0, 1) if Keyboard.key_down?(Gosu::KB_DOWN)
    drop(true) if Keyboard.key_down?(Gosu::KB_UP, only_once=true)
    spin(false) if Keyboard.key_down?(Gosu::KB_Z, only_once=true)
    spin(true) if Keyboard.key_down?(Gosu::KB_X, only_once=true)
    @player.hold if Keyboard.key_down?(Gosu::KB_C, only_once=true)
  end

  def drop(is_put)
    move!(0, 1) while !@player.collision_detection
    move!(0, -1)
    @player.put_mino if is_put
  end

  private

  def move(x, y)
    move!(x, y)
    if @player.collision_detection
      move!(-x, -y)
      @player.put_mino if y > 0
    elsif x != 0
      Gosu::Sample.new("sound/move.mp3").play
    end
  end

  def move!(x, y)
    @x += x
    @y += y
  end

  def spin(reverse)
    spin!(reverse)
    if @player.collision_detection
      spin!(!reverse) 
    else
      Gosu::Sample.new("sound/spin.mp3").play
    end
  end

  def spin!(reverse)
    new_blocks = @blocks.map(&:dup)
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block_num, x|
        if reverse
          new_blocks[-x-1][y] = block_num
        else
          new_blocks[x][-y-1] = block_num
        end
      end
    end
    @blocks = new_blocks
  end

  def init_blocks
    @blocks = MINOS[@color_num].map do |line|
      line.map do |i|
        i.zero? ? 0 : @color_num
      end
    end
  end
end

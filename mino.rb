require "./block.rb"

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

  def initialize(num, field)
    mino = MINOS[num]
    @blocks = convert_to_block(mino, num)
    @field = field
    @x = 3
    @y = -1
  end

  def update
    move(-1, 0) if Gosu::button_down?(Gosu::KB_LEFT)
    move(1, 0) if Gosu::button_down?(Gosu::KB_RIGHT)
    move(0, 1) if Gosu::button_down?(Gosu::KB_DOWN)
    drop if Gosu::button_down?(Gosu::KB_UP)
  end

  private

  def move(x, y)
    move!(x, y)
    if collision_detection
      move!(-x, -y)
      put_mino if y > 0
    end
  end

  def move!(x, y)
    @x += x
    @y += y
  end

  def drop
    move!(0, 1) while !collision_detection
    move!(0, -1)
    put_mino
  end

  def spin(reverse=false)
    spin!(reverse)
    spin!(!reverse) if collision_detection
  end

  def spin!(reverse)
    new_blocks = @blocks.map(&:dup)
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        if reverse
          new_blocks[-x-1][y] = block
        else
          new_blocks[x][-y-1] = block
        end
      end
    end
    @blocks = new_blocks
  end

  def put_mino
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        @field.set(@x + x, @y + y, block) if block.type != 0
      end
    end
    @field.renew_active_mino!
  end

  def convert_to_block(mino, num)
    mino.map do |line|
      line.map do |i|
        Block.new(i * num)
      end
    end
  end

  def collision_detection
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        return true if @field.get(@x + x, @y + y)&.type != 0 && block.type != 0
      end
    end
    false
  end
end

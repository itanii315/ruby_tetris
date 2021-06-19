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

  attr_accessor :blocks

  def initialize(num)
    mino = MINOS[num]
    @blocks = convert_to_block(mino, num)
  end

  def right_spin!
    new_blocks = @blocks.map(&:dup)
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        new_blocks[x][-y-1] = block
      end
    end
    @blocks = new_blocks
  end

  def left_spin!
    new_blocks = @blocks.map(&:dup)
    @blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        new_blocks[-x-1][y] = block
      end
    end
    @blocks = new_blocks
  end

  private

  def convert_to_block(mino, num)
    mino.map do |line|
      line.map do |i|
        Block.new(i * num)
      end
    end
  end
end

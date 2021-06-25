require './mino.rb'
require './canvas.rb'
require './color.rb'

class Field < Canvas
  BLOCK_SIZE = 20
  X_LENGTH = 10
  Y_LENGTH = 20

  def initialize(x, y, x_length=X_LENGTH, y_length=Y_LENGTH, block_size=BLOCK_SIZE)
    super x, y, x_length * block_size, y_length * block_size
    @x_length = x_length
    @y_length = y_length
    @block_size = block_size
    @field = create_field
  end

  def draw
    draw_rect_on_canvas(0, 0, @w, @h, Gosu::Color::BLACK)
    draw_blocks
  end

  def get(x, y)
    return if y < 0 || @y_length <= y
    return if x < 0 || @x_length <= x
    @field[y][x]
  end

  def set(x, y, block)
    return if y < 0 || @y_length <= y
    return if x < 0 || @x_length <= x
    @field[y][x] = block
  end

  def draw_block(x, y, c)
    super x, y, c if in_field?(x, y)
  end

  def remove_line
    @field.select! {|line| line.any?(&:zero?)}
    empty_lines = Array.new(@y_length - @field.size) { create_empty_line }
    @field = empty_lines.concat(@field)
  end

  private

  def in_field?(x, y)
    0 <= x && x < @x_length && 0 <= y && y < @y_length
  end

  def create_field
    Array.new(@y_length) { create_empty_line }
  end

  def create_empty_line
    Array.new(@x_length, 0)
  end

  def draw_blocks
    @field.each.with_index do |line, y|
      line.each.with_index do |block_num, x|
        draw_block(x, y, Color.from(block_num))
      end
    end
  end
end

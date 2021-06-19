require './block.rb'
require './mino.rb'

class Field
  def initialize(x, y, x_length, y_length, block_size)
    @x = x
    @y = y
    @x_length = x_length
    @y_length = y_length
    @block_size = block_size
    @w = @x_length * @block_size
    @h = @y_length * @block_size
    @field = create_field
    @minos = create_minos
    renew_active_mino!
  end

  def update
    @active_mino.update
  end

  def draw
    draw_rect_on_field(0, 0, @w, @h, Gosu::Color::BLACK)
    draw_blocks
    draw_active_mino
    draw_grid
  end

  def renew_active_mino!
    @active_mino = @minos.shift
    @minos.concat(create_minos) if @minos.size < 7
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

  def remove_line
    @y_length.times do |y|
      @field[y] = nil if @field[y].all? {|block| block.type != 0}
    end
    @field.compact!
    empty_lines = Array.new(@y_length - @field.size) { create_line }
    @field = empty_lines.concat(@field)
  end

  private

  def create_field
    Array.new(@y_length) { create_line }
  end

  def create_line
    Array.new(@x_length) { Block.new }
  end

  def create_minos
    (1..7).map {|i| Mino.new(i, self)}
  end

  def draw_blocks
    @field.each.with_index do |line, y|
      line.each.with_index do |block, x|
        draw_block(x, y, block.color)
      end
    end
  end

  def draw_active_mino
    @active_mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        draw_block(@active_mino.x + x, @active_mino.y + y, block.color)
      end
    end
  end

  def draw_grid
    (0..@x_length).each do |i|
      x = i * @block_size
      draw_line_on_field(x, 0, x, @h, Gosu::Color::GRAY)
    end
    (0..@y_length).each do |i|
      y = i * @block_size
      draw_line_on_field(0, y, @w, y, Gosu::Color::GRAY)
    end
  end

  def draw_block(x_num, y_num, c)
    draw_rect_on_field(x_num * @block_size, y_num * @block_size, @block_size, @block_size, c)
  end

  def draw_rect_on_field(x, y, w, h, c)
    Gosu.draw_rect(@x + x, @y + y, w, h, c)
  end

  def draw_line_on_field(x1, y1, x2, y2, c)
    Gosu.draw_line(@x + x1, @y + y1, c, @x + x2, @y + y2, c)
  end
end

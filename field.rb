require './block.rb'

class Field
  def initialize(x, y, x_length, y_length, block_size)
    @x = x
    @y = y
    @x_length = x_length
    @y_length = y_length
    @block_size = block_size
    @w = @x_length * @block_size
    @h = @y_length * @block_size
    @lines = create_field
  end
  
  def draw
    draw_rect_on_field(0, 0, @w, @h, Gosu::Color::BLACK)
    draw_blocks
    draw_grid
  end

  private

  def create_field
    Array.new(@y_length) do
      Array.new(@x_length) do
        Block.new
      end
    end
  end

  def draw_blocks
    @lines.each.with_index do |line, y|
      line.each.with_index do |block, x|
        draw_block(x, y, block.color)
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
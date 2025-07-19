class Canvas
  attr_accessor :x, :y, :w, :h
  def initialize(x, y, w, h, block_size)
    @x = x
    @y = y
    @w = w
    @h = h
    @block_size = block_size
  end

  def draw_block(x_num, y_num, c, hide_none_frame=false)
    draw_rect_on_canvas(x_num * @block_size, y_num * @block_size, @block_size, @block_size, c)
    return if hide_none_frame && c == Gosu::Color::NONE
    draw_line_on_canvas(x_num * @block_size, y_num * @block_size, (x_num + 1) * @block_size, y_num * @block_size, Gosu::Color::GRAY)
    draw_line_on_canvas(x_num * @block_size, (y_num + 1) * @block_size, (x_num + 1) * @block_size, (y_num + 1) * @block_size, Gosu::Color::GRAY)
    draw_line_on_canvas(x_num * @block_size, y_num * @block_size, x_num * @block_size, (y_num + 1) * @block_size, Gosu::Color::GRAY)
    draw_line_on_canvas((x_num + 1) * @block_size, y_num * @block_size, (x_num + 1) * @block_size, (y_num + 1) * @block_size, Gosu::Color::GRAY)
  end

  def draw_rect_on_canvas(x, y, w, h, c)
    Gosu.draw_rect(@x + x, @y + y, w, h, c)
  end

  def draw_line_on_canvas(x1, y1, x2, y2, c)
    Gosu.draw_line(@x + x1, @y + y1, c, @x + x2, @y + y2, c)
  end
end
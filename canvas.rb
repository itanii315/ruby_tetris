class Canvas
  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw_rect_on_field(x, y, w, h, c)
    Gosu.draw_rect(@x + x, @y + y, w, h, c)
  end

  def draw_line_on_field(x1, y1, x2, y2, c)
    Gosu.draw_line(@x + x1, @y + y1, c, @x + x2, @y + y2, c)
  end
end
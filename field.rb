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
    @field.select! {|line| line.any?(&:zero?)}
    empty_lines = Array.new(@y_length - @field.size) { create_empty_line }
    @field = empty_lines.concat(@field)
  end

  private

  def create_field
    Array.new(@y_length) { create_empty_line }
  end

  def create_empty_line
    Array.new(@x_length, 0)
  end

  def create_minos
    (1..7).map {|i| Mino.new(i, self)}
  end

  def draw_blocks
    @field.each.with_index do |line, y|
      line.each.with_index do |block, x|
        draw_block(x, y, color(block))
      end
    end
  end

  def draw_active_mino
    @active_mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        draw_block(@active_mino.x + x, @active_mino.y + y, color(block))
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

  def color(type)
    case type
    when 0 then Gosu::Color::NONE
    when 1 then Gosu::Color::RED
    when 2 then Gosu::Color.argb(0xff_FF8000) # ORANGE
    when 3 then Gosu::Color::YELLOW
    when 4 then Gosu::Color::GREEN
    when 5 then Gosu::Color::CYAN
    when 6 then Gosu::Color::BLUE
    when 7 then Gosu::Color::FUCHSIA # PURPLE
    end
  end
end

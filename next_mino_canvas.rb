require './canvas.rb'
class NextMinoCanvas < Canvas
  def initialize(x, y, w, h, minos)
    super x, y, w, h
    @block_size = 15
    @minos = minos
  end

  def draw
    draw_rect_on_canvas(0, 0, @w, @h, Gosu::Color::BLACK)
    @minos.first(6).each.with_index do |mino, i|
      mino.blocks.each.with_index do |line, y|
        line.each.with_index do |block_num, x|
          draw_block(1 + x, 1 + i * 3 + y, Color.from(block_num), hide_none_frame=true)
        end
      end
    end
  end
end
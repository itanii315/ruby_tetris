require './canvas.rb'
class HoldCanvas < Canvas
  attr_accessor :mino
  
  def draw
    draw_rect_on_canvas(0, 0, @w, @h, Gosu::Color::BLACK)
    return unless @mino
    @mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block_num, x|
        draw_block(1 + x, 1 + y, Color.from(block_num), hide_none_frame=true)
      end
    end
  end
end
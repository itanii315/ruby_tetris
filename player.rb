require './field.rb'
class Player
  def initialize(x, y)
    @minos = create_minos
    @field = Field.new(x, y)
    renew_active_mino!
  end

  def update
    @active_mino.update
  end

  def draw
    @field.draw
    @active_mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        @field.draw_block(@active_mino.x + x, @active_mino.y + y, Color.from(block))
      end
    end
  end

  def put_mino
    @active_mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        @field.set(@active_mino.x + x, @active_mino.y + y, block) if block != 0
      end
    end
    @field.remove_line
    renew_active_mino!
  end

  def collision_detection
    @active_mino.blocks.each.with_index do |line, y|
      line.each.with_index do |block, x|
        return true if @field.get(@active_mino.x + x, @active_mino.y + y) != 0 && block != 0
      end
    end
    false
  end

  private
  
  def renew_active_mino!
    @active_mino = @minos.shift
    @minos.concat(create_minos) if @minos.size < 7
  end

  def create_minos
    (1..7).map {|i| Mino.new(i, self)}.shuffle
  end
end
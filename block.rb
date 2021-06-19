class Block
  attr_accessor :type

  def initialize(type = 0)
    @type = type
  end

  def color
    case @type
    when 0 then Gosu::Color::NONE
    when 1 then Gosu::Color::RED
    when 2 then Gosu::Color.argb(0xff_FF8000)  # ORANGE
    when 3 then Gosu::Color::YELLOW
    when 4 then Gosu::Color::GREEN
    when 5 then Gosu::Color::CYAN
    when 6 then Gosu::Color::BLUE
    when 7 then Gosu::Color::FUCHSIA  # PURPLE
    end
  end
end

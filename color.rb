class Color
  def self.from(block_num)
    case block_num
    when 0 then Gosu::Color::NONE
    when 1 then Gosu::Color::CYAN
    when 2 then Gosu::Color::BLUE
    when 3 then Gosu::Color.argb(0xff_FF8000) # ORANGE
    when 4 then Gosu::Color::RED
    when 5 then Gosu::Color::GREEN
    when 6 then Gosu::Color::FUCHSIA # PURPLE
    when 7 then Gosu::Color::YELLOW
    end
  end
end
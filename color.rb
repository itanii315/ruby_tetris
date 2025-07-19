class Color
  def self.from(block_num, is_shadow=false)
    if is_shadow
      case block_num
      when 0 then Gosu::Color::NONE
      when 1 then Gosu::Color.argb(0x80_00FFFF) # CYAN
      when 2 then Gosu::Color.argb(0x80_0000FF) # BLUE
      when 3 then Gosu::Color.argb(0x80_FF8000) # ORANGE
      when 4 then Gosu::Color.argb(0x80_FF0000) # RED
      when 5 then Gosu::Color.argb(0x80_00FF00) # GREEN
      when 6 then Gosu::Color.argb(0x80_FF00FF) # PURPLE
      when 7 then Gosu::Color.argb(0x80_FFFF00) # YELLOW
      end
    else
      case block_num
      when 0 then Gosu::Color::NONE
      when 1 then Gosu::Color.argb(0xff_00FFFF) # CYAN
      when 2 then Gosu::Color.argb(0xff_0000FF) # BLUE
      when 3 then Gosu::Color.argb(0xff_FF8000) # ORANGE
      when 4 then Gosu::Color.argb(0xff_FF0000) # RED
      when 5 then Gosu::Color.argb(0xff_00FF00) # GREEN
      when 6 then Gosu::Color.argb(0xff_FF00FF) # PURPLE
      when 7 then Gosu::Color.argb(0xff_FFFF00) # YELLOW
      end
    end
  end
end
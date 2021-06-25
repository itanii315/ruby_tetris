class Keyboard
  @keys = {}

  def self.key_down?(key, only_once=false)
    @keys[key] ||= -1
    if !Gosu::button_down?(key)
      @keys[key] = -1
      return false
    end
    @keys[key] += 1
    return true if @keys[key].zero?
    return false if only_once
    return false if @keys[key] <= 6
    true
  end
end
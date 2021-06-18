require 'gosu'

class Tutorial < Gosu::Window
  SCREEN_W = 640
  SCREEN_H = 480
  BLOCK_SIZE = 20
  X_LENGTH = 10
  Y_LENGTH = 20
  FIELD_X = 40
  FIELD_Y = 40
  FIELD_W = X_LENGTH * BLOCK_SIZE
  FIELD_H = Y_LENGTH * BLOCK_SIZE

  def initialize
    super SCREEN_W, SCREEN_H
    self.caption = "Tetris"
  end

  def update
  end

  def draw
    draw_rect(0, 0, SCREEN_W, SCREEN_H, Gosu::Color::WHITE)
    draw_rect(FIELD_X, FIELD_Y, BLOCK_SIZE * X_LENGTH, BLOCK_SIZE * Y_LENGTH, Gosu::Color::BLACK)
    (0..X_LENGTH).each do |i|
      x = i * BLOCK_SIZE
      draw_line_on_field(x, 0, x, FIELD_H, Gosu::Color::GRAY)
    end
    (0..Y_LENGTH).each do |i|
      y = i * BLOCK_SIZE
      draw_line_on_field(0, y, FIELD_W, y, Gosu::Color::GRAY)
    end
    # Gosu.draw_line(x1, y1, c, x2, y2, c)
  end

  private

  def draw_rect_on_field(x, y, w, h, c)
    Gosu.draw_rect(FIELD_X + x, FIELD_Y + y, w, h, c)
  end

  def draw_line_on_field(x1, y1, x2, y2, c)
    Gosu.draw_line(FIELD_X + x1, FIELD_Y + y1, c, FIELD_X + x2, FIELD_Y + y2, c)
  end
end

Tutorial.new.show

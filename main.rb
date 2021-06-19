require 'gosu'
require './field.rb'

class Tetris < Gosu::Window
  SCREEN_W = 640
  SCREEN_H = 480
  BLOCK_SIZE = 20
  X_LENGTH = 10
  Y_LENGTH = 20

  def initialize
    super SCREEN_W, SCREEN_H
    self.caption = "Tetris"

    @field = Field.new(40, 40, X_LENGTH, Y_LENGTH, BLOCK_SIZE)
  end

  def update
    @field.update
  end

  def draw
    draw_rect(0, 0, SCREEN_W, SCREEN_H, Gosu::Color::WHITE)
    @field.draw
  end
end

Tetris.new.show

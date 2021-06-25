require 'gosu'
require './player.rb'

class Tetris < Gosu::Window
  SCREEN_W = 640
  SCREEN_H = 480

  def initialize
    super SCREEN_W, SCREEN_H
    self.caption = "Tetris"

    @player = Player.new(40, 40)
  end

  def update
    @player.update
  end

  def draw
    Gosu.draw_rect(0, 0, SCREEN_W, SCREEN_H, Gosu::Color::WHITE)
    @player.draw
  end
end

Tetris.new.show

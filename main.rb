require 'gosu'
require './player.rb'

class Tetris < Gosu::Window
  SCREEN_W = 640
  SCREEN_H = 480

  def initialize
    super SCREEN_W, SCREEN_H
    self.caption = "Tetris"

    @player = Player.new
    @back_ground_image = Gosu::Image.new("image/back_ground.jpeg")
    @bgm = Gosu::Song.new("sound/bgm.mp3")
    @bgm.volume = 0.6
    @bgm.play(true)
  end

  def update
    @player.update
  end

  def draw
    # Gosu.draw_rect(0, 0, SCREEN_W, SCREEN_H, Gosu::Color::WHITE)
    @back_ground_image.draw(0, 0, 0)
    @player.draw
  end
end

Tetris.new.show

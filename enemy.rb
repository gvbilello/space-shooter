require_relative 'helpers'

require 'pry'
require 'pry-byebug'

class Enemy

	include Helpers

	attr_reader :x, :y

	SPRITE = Helpers.media_path('enemy01.png')
	FRAME_DELAY = 120

	def load_animation(window)
		Gosu::Image.load_tiles(window, SPRITE, 48, 48, false)
	end

	def initialize(window)
		@window = window
		@enemy = load_animation(@window)
		@x = 800 + 20
		@y = rand(200..400)
		@velocity = rand(-8..-2)
		@current_frame = 0
		@projectiles = []
	end

	def draw
		current_frame.draw(@x, @y, 0)
	end

	def update
		@current_frame += 1 if frame_expired?
		@current_frame = 0 if @current_frame == 2
		@x += @velocity
	end

	private

	def current_frame
		@enemy[@current_frame]
	end

	def frame_expired?
		now = Gosu.milliseconds
		@last_frame ||= now
		if (now - @last_frame) > FRAME_DELAY
			@last_frame = now
		end
	end

end
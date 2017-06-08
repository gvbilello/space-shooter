require 'gosu'

require_relative 'helpers'

class Player

	include Helpers

	attr_reader :x, :y

	SPRITE = Helpers.media_path('player_ship_large.png')
	FRAME_DELAY = 60

	def load_animation(window)
		Gosu::Image.load_tiles(window, SPRITE, 72, 30, false)
	end

	def initialize(window)
		@window = window
		@player = load_animation(@window)
		@x = @window.height / 2
		@y = 50
		@current_frame = 0
	end

	def can_move_left?
		return true if @x > 0
	end

	def can_move_right?
		return true if @x < 728
	end

	def can_move_up?
		return true if @y > 0
	end

	def can_move_down?
		return true if @y < 570
	end

	def move_left
		if @window.button_down?(Gosu::KbLeft) && can_move_left?
			@x -= 5
		end
	end

	def move_right
		if @window.button_down?(Gosu::KbRight) && can_move_right?
			@x += 5
		end
	end

	def move_up
		if @window.button_down?(Gosu::KbUp) && can_move_up?
			@y -= 5
		end
	end

	def move_down
		if @window.button_down?(Gosu::KbDown) && can_move_down?
			@y += 5
		end
	end

	def draw
		current_frame.draw(@x, @y, 1)
	end

	def update
		move_left
		move_right
		move_up
		move_down
		@current_frame += 1 if frame_expired?
		if @current_frame == 2
			@current_frame = 0
		end
	end

	private

	def current_frame
		@player[@current_frame]
	end

	def frame_expired?
		now = Gosu.milliseconds
		@last_frame ||= now
		if (now - @last_frame) > FRAME_DELAY
			@last_frame = now
		end
	end

end
require 'pry'
require 'pry-byebug'

class PlayerProjectile

	attr_reader :x, :y

	def initialize(window, player)
		@window = window
		@player = player
		@x = @player.x + 60
		@y = @player.y + 10
		@velocity = 10
		@image = Gosu::Image.new("media/player_projectile.png")
	end

	def draw
		@image.draw(@x, @y, 0)
	end

	def update
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
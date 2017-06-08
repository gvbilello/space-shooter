require 'gosu'

class Star

	attr_reader :x, :y, :velocity

	def initialize(args = {})
		@x = args.fetch(:x)
		@y = args.fetch(:y)
		@velocity = args.fetch(:velocity)
		@color = Gosu::Color.argb(0xff_ffffff)
		@image = [Gosu::Image.new("media/star.png"), Gosu::Image.new("media/medium_star.png")].sample
	end

	def draw
		@image.draw(@x, @y, 0)
	end

	def update
		@x -= @velocity
	end

end
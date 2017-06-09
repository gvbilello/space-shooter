require_relative 'star'
require_relative 'player'

class GameWindow < Gosu::Window

	def initialize(width = 800, height = 600, fullscreen = false)
		super
		@player = Player.new(self)
		@background_stars = []
		@moving_stars = []
		create_background_stars
		create_moving_stars
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

	def create_background_stars
		50.times do
			@background_stars << Star.new(x: rand(800), y: rand(600), velocity: 0)
		end
	end

	def create_moving_stars
		100.times do
			@moving_stars << Star.new(x: rand(800), y: rand(600), velocity: rand(0.01..3.1))
		end
	end

	def add_moving_star(star)
		@moving_stars << Star.new(x: 800, y: star.y, velocity: star.velocity)
	end

	def draw
		@player.draw
		@background_stars.each { |star| star.draw }
		@moving_stars.each { |star| star.draw }
	end

	def update
		@player.update
		@moving_stars.each do |star|
			star.update
			if star.x <= 0
				add_moving_star(star)
				@moving_stars.delete(star)
			end
		end
	end

end
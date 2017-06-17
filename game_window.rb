require_relative 'star'
require_relative 'player'
require_relative 'enemy'

require 'pry'
require 'pry-byebug'

class GameWindow < Gosu::Window

	ENEMY_DELAY = 500

	def initialize(width = 800, height = 600, fullscreen = false)
		super
		@player = Player.new(self)
		@background_stars = []
		@moving_stars = []
		@enemies = []
		create_background_stars
		create_moving_stars
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

	def create_enemy
		@enemies << Enemy.new(self)
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

	def projectile_impact_enemy?(projectile)
		@enemies.each do |enemy|
			if projectile.x + 19 >= enemy.x
				if projectile.y >= enemy.y
					if projectile.y + 8 <= enemy.y + 48
						return enemy
					end
				end
			end
		end
	end

	def draw
		@player.draw
		@background_stars.each { |star| star.draw }
		@moving_stars.each { |star| star.draw }
		@enemies.each { |enemy| enemy.draw }
	end

	def update
		@player.projectiles.each do |projectile|
			destroyed_enemy = projectile_impact_enemy?(projectile)
			if destroyed_enemy
				@enemies.delete(destroyed_enemy)
			end
		end
		create_enemy if add_enemy?
		@player.update
		@moving_stars.each do |star|
			star.update
			if star.x <= 0
				add_moving_star(star)
				@moving_stars.delete(star)
			end
		end
		@enemies.each do |enemy|
			enemy.update
			if enemy.x <= -48
				@enemies.delete(enemy)
			end
		end
	end

	private

	def add_enemy?
		now = Gosu.milliseconds
		@last_projectile ||= now
		if (now - @last_projectile) > ENEMY_DELAY
			@last_projectile = now
		end
	end

end
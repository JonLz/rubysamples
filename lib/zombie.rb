class Mutant
end

class Zombie < Mutant
	attr_accessor :name, :brains

	def initialize
		@brains = 0
		@name = 'Jon'
	end

	def hungry?
		true
	end
end
##
# Conway's Game of Life
# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
#
# A very memory inefficient solution.  Damn is R-Pentomino not awesome though?!?
## 

LIVE_CELL = ?*
DEAD_CELL = ?.

class Game
	def initialize(rows,cols)
		@rows=rows
		@cols=cols
		@board=base_array
	end

	#set the initial state of the game based on an array of x,y coordinates to turn into live cells
	def set_state(state)
		state.each do |row,col|
				@board[row][col] = LIVE_CELL
			end
	end

  #Array.new(rows) {cols} will create multiple copies of the column array (good)
	#Array.new(rows,cols) doesn't work because it sets the columns to a reference of the column array (bad)
	def base_array
		Array.new(@rows) {Array.new(@cols, DEAD_CELL)}
	end

	#iterates to the next state based on assessing the number of alive neighboring cells for each cell
	def next_state
		new_board = base_array
		@rows.times do |row|
			@cols.times do |col|
				if alive?(row,col) then
					case alive_neighbors(row,col)
						when 0..1 then
							new_board[row][col] = DEAD_CELL
						when 4..9 then
							new_board[row][col] = DEAD_CELL
						when 2..3 then
							new_board[row][col] = LIVE_CELL
					end
				elsif alive_neighbors(row,col) == 3 then 
					new_board[row][col] = LIVE_CELL
				end
			end
		end
		@board = new_board
		to_s
	end

	#is the current cell alive?
	def alive?(r,c)
		return false if @board[r][c] == DEAD_CELL
		return true
	end

	#
	#   neighbors
	#   [row-1,col-1] [row-1,col] [row-1,col+1]
	#   [row,col-1]      point      [row,col+1]
	#   [row+1,col-1] [row+1,col] [row+1,col+1]
	#
	# returns the number of alive neighbors
	def alive_neighbors(row,col)
		neighbors=Array.new
		(-1..1).each do |x|
			(-1..1).each do |y|
				# go to the next neighboring cell if we're past the boundaries of the board or if we are in
				# the current cell
				next if row+x < 0				#top border
				next if col+y < 0				#left border
				next if (x==0 and y==0)	#center
				next if row+x>@rows-1		#bottom border
				next if col+y>@cols-1		#right border

				neighbors << @board[row+x][col+y]
			end
		end

		neighbors.count(LIVE_CELL)	#the moneymaker
	end

	#output the entire board to the screen
	def to_s
		@board.each do |row|
			row.each do |col|
				print col
			end
			print "\n"
		end
	end
end

# clear the IRB console
def cls
	system('cls')
end

# feel free to change these
rows = 20
cols = 40

game = Game.new(rows,cols)

# These are the preset game state and the figures they represent

# Oscillators
#game.set_state([[5,5],[5,6],[5,7]])
#game.set_state([[5,5],[5,6],[5,7],[6,4],[6,5],[6,6]])

# Glider
#game.set_state([[0,1],[1,2],[2,0],[2,1],[2,2]])

# Kaboom
#game.set_state [[0,1],[1,2],[2,0],[2,1],[2,2],[5,5],[5,6],[5,7],[6,4],[6,5],[6,6]]

# R-Pentomino
game.set_state [[7,17],[7,18],[8,16],[8,17],[9,17]]

cls
game.to_s
sleep 0.6
cls

1000.times do
	game.next_state
	sleep 0.1
	cls
end

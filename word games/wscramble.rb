DEBUG = false

# declare constant letter array and use it to build a score hash of scrabble letter tile values
LETTERS = ('a'..'z').to_a

SCORE = Hash.new
LETTERS.each do |letter|
  SCORE[letter] = 1 unless letter.scan(/[aeioulnrst]/).empty?
  SCORE[letter] = 2 unless letter.scan(/[dg]/).empty?
  SCORE[letter] = 3 unless letter.scan(/[bcmp]/).empty?
  SCORE[letter] = 4 unless letter.scan(/[fhvwy]/).empty?
  SCORE[letter] = 5 unless letter.scan(/[k]/).empty?
  SCORE[letter] = 8 unless letter.scan(/[jx]/).empty?
  SCORE[letter] = 10 unless letter.scan(/[qz]/).empty?
end

# array of each tile position (0 - 15) and the adjacent tiles for our word builder method
ADJACENT = [
  [1, 4, 5],                      #0
  [0, 2, 4, 5, 6],                #1
  [1, 3, 5, 6, 7],                #2
  [2, 6, 7],                      #3
  [0, 1, 5, 8, 9],                #4
  [0, 1, 2, 4, 6, 8, 9, 10],      #5
  [1, 2, 3, 5, 7, 9, 10, 11],     #6
  [2, 3, 6, 10, 11],              #7
  [4, 5, 9, 12, 13],              #8
  [4, 5, 6, 8, 10, 12, 13, 14],   #9
  [5, 6, 7, 9, 11, 13, 14, 15],   #10
  [6, 7, 10, 14, 15],             #11
  [8, 9, 13],                     #12
  [8, 9, 10, 12, 14],             #13
  [9, 10, 11, 13, 15],            #14
  [10, 11, 14]                    #15
]

# contains all methods to solve a board and score it
module Solver
# check if a given word is on the board
def valid_word?(word, board="", prefix="", cell = -1)

# find letter on board
word = word.downcase
board = @board if board.length == 0

if DEBUG then
  puts "word: #{word}"
  puts "board: #{board}"
  puts "prefix: #{prefix}"
  puts "cell: #{cell}"
  puts
end

# we need to check for every starting letter match on the board all the way through [iteration 0]
if prefix.length == 0 then
  (0..15).each do |i|
    if board[i] == word[0] then
      # copy the board, replace the found letter with a * so we don't re-use it and then updated the prefix
      board_copy = board.dup
      board_copy[i] = '*'

      newprefix = board[i,1]

      # return true if we found a valid letter in our word (recursive call)
      return true if valid_word?(word, board_copy, newprefix, i)
    end #end if
  end #end do
  
  # we didn't find a word on this branch so return false
  return false

# we found the word [final iteration]
elsif prefix.length == word.length
  return true

# we need to check all adjacent cells [iteration 1+] with the same method described above
else
  ADJACENT[cell].each do |c|
    if board[c] == word[prefix.length] then
      board_copy = board.dup
      board_copy[c] = '*'

      newprefix = prefix + board[c,1]

      return true if valid_word?(word, board_copy, newprefix, c)
    end #end if
  end #end do

  # nothing found, return false
  return false

end #end if

end #end def valid_word?

# generate all dictionary words found on the board
def generate_words
  words = Hash.new

  # TODO - add error handling
  dictionary = "bigdict.txt"
  dictionary = "test.txt" if DEBUG
  
  # for benchmarking purposes, we search 80k records in about 1 second. mindblowing increase in computing power since 1980!
  time = Time.new

  File.foreach dictionary do |word|
    word.chomp!
    words[word] = score_word(word) if valid_word?(word)
  end #end file.each

  time = Time.new - time

  # output all words in descending score value
  words.sort_by { |word, score| score }.reverse.each do |result|
    puts "#{result[0]} - #{result[1]}"
  end

  puts "Found #{words.length} words in #{time} seconds"
end #end def generate_words

# calculate a score for the word based on the SCORE array
def score_word(word)
  sum = 0
  word.split(//).each {|letter| sum += SCORE[letter] }
  sum
end #end def score_word

end #end module Solver

# contains all methods to build, re-init, and display a board object
class Board
include Solver
attr_reader :board

def initialize
  @board = String.new
  set_board
end

# display a board in a familiar 4x4 grid manner
def to_s
  board = @board.dup.upcase
  (1..17).each do |idx|
    print board[idx-1]
    print " " unless idx == 17
    puts if idx % 4 == 0
  end
end

# for a user to input their own board
# TODO - add more error handling and input validation
def input_board
  print "Enter your board with no spaces (ex: CUTERUBYCUBEKOAN): "
  line = gets.chomp
  if line.length != 16 then
    puts "You input the board incorrectly."
    return
  end
  @board = line.to_s
  to_s
end

# private methods used in generating a default board
private

def set_board
  16.times { @board << LETTERS[rand(25)] } 
  if count_vowels < 4 then 
    @board = ""
    set_board
  end

  @board = "cuterubycubekoan" if DEBUG
end

def count_vowels
  @board.scan(/[aeiou]/).count
end
end

board = Board.new
puts board
line = ""

# control loop and main program UI
while line != 'x'
  print "(v)iew board, (g)enerate words, (n)ew board, (i)nput board, e(x)it: "
  line = gets.chomp

  case line
  when 'v' then puts board
  when 'g' then board.generate_words
  when 'i' then board.input_board
  when 'n' then 
    board = Board.new
    puts board
  when 'x' then break
  else 
    if board.valid_word?(line) then
      puts "It's on the board!" 
    else
      puts "Not on the board."
    end
  end
end

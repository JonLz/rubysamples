# hacked up Scrabble solver
# does not support ? (blank) tiles

# read in a dictionary of some English words
dict = File.new("dict.txt", 'r')

if dict
   word_list = dict.sysread(dict.size).downcase.split(' ')
else
   puts "Unable to open file!"
   exit
end

# get user's letters
# needs input validation for production
print "Enter letters: "
letters = gets.downcase.split(//)

# deletes every element of self for which block evaluates to false
words = word_list.keep_if do |word|
        # split the word into its letters.
        word = word.split(//)

        # strip the letters that are in our hand from the word.
        letters.each do |letter|
          unless word.index(letter).nil?
            word.delete_at word.index(letter)
          end
        end

        # keep the words that match
        word.length == 0

      end

# final output in ugly array form
puts words.inspect

	



class FizzBuzz

	# "brute force" solution
	def Fizz1
		(1..100).each do |x|
			print x unless x % 3 == 0 or x % 5 == 0
			print "Fizz" if x % 3 == 0
			print "Buzz" if x % 5 == 0
			print "\n"
		end
	end

	# cleaner solution using basic array and string functions
	def Fizz2
		(1..100).each do |x|
			str = [("Fizz" if x % 3 == 0),("Buzz" if x % 5 == 0)].compact.join
			if str == "" then str << x.to_s end
			puts str		
		end
	end
end

puts "Solution 1:\n"
FizzBuzz.new.Fizz1
puts "\nSolution 2:"
FizzBuzz.new.Fizz2

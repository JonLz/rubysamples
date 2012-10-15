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

	# modular and scalable solution
	def add(int)
		string = String.new
		string << "Fizz" if int % 3 == 0
		string << "Buzz" if int % 5 == 0
		string << "Bazz" if int % 7 == 0
		string
	end
	def Fizz3(i)
		(1..i).each do |x|
			prime = add(x)
			if prime.empty? then puts x
			else puts prime
			end
		end
	end
end


#puts "Solution 1:\n"
#FizzBuzz.new.Fizz1
#puts "\nSolution 2:"
#FizzBuzz.new.Fizz2
puts "Solution 3:"
FizzBuzz.new.Fizz3(150)
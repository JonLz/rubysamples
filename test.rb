class FizzBuzz
	def Fizz1
		(1..100).each do |x|
			print x unless x % 3 == 0 or x % 5 == 0
			print "Fizz" if x % 3 == 0
			print "Buzz" if x % 5 == 0
			print "\n"
		end
	end

	def Fizz2
		(1..100).each do |x|
			str = [("Fizz" if x % 3 == 0),("Buzz" if x % 5 == 0)].compact.join
			if str == "" then str << x.to_s end
			puts str		
		end
	end
end

FizzBuzz.new.Fizz1
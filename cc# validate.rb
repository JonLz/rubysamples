=begin
Credit card numbers can be validated with a process called the Luhn algorithm. 
Simply stated, the Luhn algorithm works like this:

Starting with the next to last digit and continuing with 
every other digit going back to the beginning of the card, double the digit.

Sum all doubled and untouched digits in the number.
If that total is a multiple of 10, the number is valid.

For example, given the card number 4408 0412 3456 7893:
Orig  :  4 4 0 8 0 4 1 2 3 4   5 6   7 8   9 3
Step 1:  8 4 0 8 0 4 2 2 6 4  10 6  14 8  18 3
Step 2:  8+4+0+8+0+4+2+2+6+4+1+0+6+1+4+8+1+8+3 = 70
Step 3:  70 % 10 == 0

This card is valid!
=end

# Here's a very lengthy implementation using the basic iterators and enumeration I'm familiar with so far!

def valid_credit_card?(num)
# Split the string into an array so we can work with each digit
# Reverse the string so we can double every other number
	card = num.split(//).reverse.each_with_index.map do |num, index| 
		if index % 2 != 0 then
			num.to_i * 2
		else
			num.to_i
		end
	end	

# There must be a better way to do this, but the idea is to turn the array into a string
# and back into an array to turn the double digit numbers into single digits.. /sigh
	card.to_s
	.gsub(/,/,'')
	.gsub(/\[/,'')
	.gsub(/\]/,'')
	.gsub(/ /,'')
	.split('')
	.map {|i| i.to_i}
	.reduce(:+) % 10 == 0
end

p valid_credit_card?("1234567890123456")
p valid_credit_card?("4408041234567893")
p valid_credit_card?("440804l234567893")
p valid_credit_card?("38520000023237")
p valid_credit_card?("4222222222222")


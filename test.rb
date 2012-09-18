def valid_credit_card?(num)
	card = num.split(//).reverse.each_with_index.map do |num, index| 
		if index % 2 != 0 then
			num.to_i * 2
		else
			num.to_i
		end
	end	
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


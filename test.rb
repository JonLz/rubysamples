def pirates_say_arrrrrrrrr(string)
	str=""
	string.scan(/([Rr])(.)/) { |y,ltr| str << ltr.to_s }
	p str
end

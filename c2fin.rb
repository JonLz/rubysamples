puts "Reading Celsius temperature value from data file..."
fahrenheit = File.read("temp.dat")
puts "The number is " + fahrenheit
print "Result: "
puts fahrenheit.to_i * 9/ 5 + 32
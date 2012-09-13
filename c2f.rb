celsius = File.read("temp.dat")
print "Converting " + celsius + " degrees celsius to fahrenheit"
fahrenheit = celsius.to_i * 9 / 5 + 32
fh = File.new("temp.out", "w")
fh.puts fahrenheit
fh.close
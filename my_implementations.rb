# Integer.times
class Integer
  def my_times(c=0)
    until c == self
    yield(c)
    c+=1
    end
  self
  end
end

4.my_times { |num| puts "R U B Y" }

# Array.each
class Array
  def my_each(c=0)
    until c == self.size
      yield(self[c])
      c+=1
    end
  self
  end
end

%w(R U B Y).my_each { |x| puts x }

# Array.each in terms of Integer.times
class Array
  def my_integer_each
    self.size.times { |index| yield(self[index]) }
    self
  end
end

%w(R U B Y).my_integer_each { |x| puts x }

# Integer.each in terms of Array.each
class Integer
  def my_array_times
    (0..self).each { |num| yield(num) }
    self
  end
end

4.my_times { |num| puts "R U B Y" }

# Array.map 
class Array
  def my_map
    c = 0
    arr = []
    # take each element
    until c == self.size
      # yield it to the block
      arr << yield(self[c])
      c+=1
    end
    # return the Array
    arr
  end
end

p %w(R U B Y).my_map { |letter| letter.downcase }

# Array.map in terms of each
class Array
  def my_each_map
    arr = []
    self.my_each { |c| arr << yield(c) }
    arr
  end
end

p %w(r u b y).my_map { |letter| letter.upcase }
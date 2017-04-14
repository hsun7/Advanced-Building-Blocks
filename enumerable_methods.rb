module Enumerable
  def my_each
    idx = 0
    while idx < self.length
      yield(self[idx])
      idx += 1
    end
    self
  end

  def my_each_with_index
    for item in self
      yield(item, self.index(item))
    end
    self
  end

  def my_select
    result = []
    self.my_each do |item|
      result << item if yield(item) == true
    end
    return result
  end

  def my_all?
    never_false = true
    if block_given?
      self.my_each do |element|
        never_false = false if (yield(element) == false || yield(element) == nil)
      end
    else
      never_false = false if self.length > 0
    end

    return never_false
  end

  def my_any?
    once_true = false
    if block_given?
      self.my_each do |element|
        once_true = true if yield(element) == true
      end
    else
      once_true = true if self.length > 0
    end
    return once_true
  end

  def my_none?
    never_false = true
    if block_given?
      self.my_each do |element|
        never_false = false if yield(element) == true
      end
    else
      for item in self
        if !!item == true
          never_false = false
        end
      end
    end
    return never_false
  end

  def my_count(num = nil)
    counter = 0

    if num != nil
      for item in self
        counter += 1 if item == num
      end
      puts "warning: given block not used" if block_given?
    else
      return self.size if num == nil && !block_given?
      self.my_each do |element|
        counter += 1 if yield(element) == true
      end
    end

    return counter
  end

  def my_map
    temp_arr = []
    return to_enum(:my_map) unless block_given?
    for item in self
      temp_arr << yield(item)
    end
    return temp_arr
  end

  def my_inject(initial_value=0)
    total = initial_value
    self.my_each do |element|
      total = yield(total, element)
    end
    return total
  end

  def my_reduce
    self.my_inject
  end

  def multiply_els
    self.to_a.my_inject(1) { |product, n| product * n }
  end

  def my_map_proc(&proc)
    arr = []
    if proc
      for i in self
        arr.push(proc.call(i))
      end
      return arr
    end
    return to_enum(:my_map_proc)
  end
end


arr = %w(hello world yo)
arr1 = (1..5).to_a
arr2 = %w[ant bear cat]
arr3 = [1, 2, 4, 2, 0, 5]
p arr1
puts
[1, 2, 3].my_each { |x| print x }
puts; puts
arr.my_each_with_index { |item, idx| puts "#{idx}: #{item}" }
puts
p arr1.my_select { |x| x.odd? }
puts
p arr1.my_all? { |x| x >= 1 }
p arr1.my_all? { |x| x > 1 }
p arr1.my_all? { |x| x == 5 }
p [].my_all? # should be true
p [nil, true, 99].my_all? # should be false
puts
p arr1.my_any? { |x| x > 5 }
p arr1.my_any? { |x| x == 5 }
p [nil, true, 99].my_any? # should be true
p [].my_any? # should be false
puts
p arr2.my_none? { |word| word.length > 5 } # should return true
p arr2.my_none? { |word| word.length == 4 } # should return false
p arr2.my_none? # should return false
p [].my_none? # should return true
p [nil, false].my_none? # should return true
p [nil, false, true].my_none? # should return false
puts
p arr3.my_count # should return 6
p arr3.my_count(2) # should return 2
p arr3.my_count { |x| x % 2 == 0 } # should return 4
p arr3.my_count(2) { |x| x % 2 == 0 }
puts
p arr2.my_map { |word| word + '!' }
p arr1.my_map { |num| num * 2 }
p arr1.my_map
puts
p arr1.inject { |sum, n| sum + n }
p (5..10).inject { |sum, n| sum + n }
p arr1.reduce{ |sum, n| sum + n }
p arr1.reduce(2) { |sum, n| sum + n }
puts
p %w[foo bar blah].my_map { |e| e.upcase }
p (5..10).multiply_els
p [2, 4, 5].multiply_els
puts
p (1..4).my_map_proc { |i| i * i }
p (1..4).my_map_proc { 'cats' }
p (1..4).my_map_proc
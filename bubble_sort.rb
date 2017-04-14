# Build a method #bubble_sort that takes an array and returns a sorted array. It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn't it?).
 # > bubble_sort([4,3,78,2,0,2])
 #    => [0,2,2,3,4,78]
class Array
  def bubble_sort
    while true do
      idx = 0
      sorted_counter = 0
      while idx < self.length - 1
        if self[idx] > self[idx + 1]
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
        else
          sorted_counter += 1
        end
        idx += 1
      end
      break if sorted_counter == self.length - 1
    end

    return self
  end

  def equal_to_sort
    (self.bubble_sort == self.sort) ? true : false
  end
end
p [3, 2, 1].bubble_sort
p [4, 3, 78, 2, 0, 2].bubble_sort
p [4, 3, 78, 2, 0, 2].equal_to_sort
p [43, 5, 3, 1, 4, 6, 7].bubble_sort
puts


def bubble_sort_by(arr)
  while true
    idx = 0
    sorted_counter = 0
    while idx < arr.length - 1
      if yield(arr[idx], arr[idx+1]) > 0
        arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
      else
        sorted_counter += 1
      end
      idx += 1
    end
    break if sorted_counter == arr.length - 1
  end
  p arr
end

a = %w(hi hello hey)
b = %w(yeah yo pizza apples orange)
# p a
# p a.sort
bubble_sort_by(a) do |left, right|
  left.length - right.length
end


bubble_sort_by(b) { |left, right| left.length - right.length }
# frozen_string_literal: true

array = []
n = 1
while n <= 100
  if array.size <= 1
    array << 1
  else
    n = array[-2] + array[-1]
    break if n > 100

    array << n
  end
end
puts "Array is #{array}"

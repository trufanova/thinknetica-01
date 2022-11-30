# frozen_string_literal: true

puts 'Enter a: '
a = gets.to_f
puts 'Enter b: '
b = gets.to_f
puts 'Enter c: '
c = gets.to_f
d = b**2 - 4 * a * c
x1 = 0
x2 = 0
if d.negative?
  puts 'No roots'
else
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  if x1 == x2
    puts "D = #{d}, x1 = #{x1}"
  else
    puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
  end
end

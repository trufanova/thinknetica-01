# frozen_string_literal: true

puts 'Enter lengts first side of triangle: '
a = gets.to_f
puts 'Enter lengts second side of triangle: '
b = gets.to_f
puts 'Enter lengts third side of triangle: '
c = gets.to_f

if a**2 == b**2 + c**2 || b**2 == a**2 + c**2 || c**2 == a**2 + b**2
  puts 'This triangle is right angled'
elsif a == b && b == c
  puts 'This triangle is equilateral'
elsif a == b || b == c || a == c
  puts 'This triangle is isosceles'
end

# frozen_string_literal: true

puts "What's your name?"
name = gets.chomp.capitalize
puts "What's your height?"
height = gets.to_f
idealweight = (height - 110) * 1.15
if idealweight.negative?
  puts "#{name}, your weight is already ideal"
else
  puts "#{name}, your ideal weight is #{idealweight.round(2)}"
end

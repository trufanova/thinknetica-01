# frozen_string_literal: true

def leap_year(year)
  return false if (year % 4) != 0
  return true if (year % 100) != 100
  return true if (year % 400).nil?

  false
end

months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30,
           10 => 31, 11 => 30, 12 => 31 }

puts 'Enter day: '
user_day = gets.to_i
puts 'Enter month by digits: '
user_month = gets.to_i
puts 'Enter year: '
user_year = gets.to_i

months[2] = 29 if leap_year(user_year)

number_of_day = 0
months.each do |month, days|
  break if month == user_month

  number_of_day += days
end
number_of_day += user_day
puts number_of_day

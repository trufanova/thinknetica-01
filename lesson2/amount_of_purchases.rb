# frozen_string_literal: true

cart = {}
loop do
  puts "Enter product name or 'stop' to stop entering"
  product = gets.chomp.downcase.to_sym
  break if product == :stop

  puts 'Enter price: '
  price = gets.to_f
  puts 'Enter amount: '
  amount = gets.to_f

  cart[product] = { price => amount }
end
puts "Cart: #{cart}"
sum_of_cart = 0
cart.each do |product, details|
  details.each do |price, amount|
    sum_of_cart += price * amount
    puts "#{product}: #{price * amount}"
  end
end
puts "Total: #{sum_of_cart}"

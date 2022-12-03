# frozen_string_literal: true

alphabet = (:a..:z).to_a
vowels = %i[a e i o u y]
vowels_hash = {}
alphabet.each_with_index do |letter, index|
  vowels_hash[letter] = index if vowels.include? letter
end
puts vowels_hash

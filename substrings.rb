def substrings(text, dictionary)
  result = Hash.new(0)
  text = text.downcase

  dictionary.each do |word|
    count = text.scan(word.downcase).length
    result[word] = count if count > 0
  end

  result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
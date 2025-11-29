def caesar_cipher(string, shift)
  result = ""

  string.each_char do |char|
    # Check if character is a letter
    if char.match?(/[A-Za-z]/)
      base = char >= "a" ? "a".ord : "A".ord

      # Shift the letter and wrap using modulo
      new_char = ((char.ord - base + shift) % 26) + base

      result << new_char.chr
    else
      # Non-letters stay the same (spaces, punctuation, etc.)
      result << char
    end
  end

  result
end

puts caesar_cipher("What a string!", 5)
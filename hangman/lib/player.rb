class Player
  def get_input
    loop do
      input = gets.chomp.downcase
      return input if input == "save"
      return input if input.match?(/^[a-z]$/)

      puts "Invalid input. Enter a single letter or 'save'."
    end
  end
end

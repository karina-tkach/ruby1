class Mastermind
  COLORS = %w[R G B Y O P] # Red, Green, Blue, Yellow, Orange, Purple
  CODE_LENGTH = 4
  MAX_TURNS = 12

  def initialize
    puts "Welcome to Mastermind!"
    choose_role
  end

  def choose_role
    puts "Do you want to be the (G)uesser or the (C)reator of the secret code?"
    choice = gets.chomp.upcase

    if choice == "G"
      @secret_code = generate_code
      human_guesses
    else
      @secret_code = human_code
      computer_guesses
    end
  end

  # Generate a random code
  def generate_code
    Array.new(CODE_LENGTH) { COLORS.sample }
  end

  # Human sets the secret code
  def human_code
    puts "Enter your secret code (#{CODE_LENGTH} letters from #{COLORS.join(", ")}):"
    loop do
      code = gets.chomp.upcase.chars
      if valid_code?(code)
        return code
      else
        puts "Invalid code. Try again:"
      end
    end
  end

  def valid_code?(code)
    code.length == CODE_LENGTH && code.all? { |c| COLORS.include?(c) }
  end

  # Human guesses computer code
  def human_guesses
    MAX_TURNS.times do |turn|
      puts "Turn #{turn + 1}/#{MAX_TURNS}: Enter your guess:"
      guess = gets.chomp.upcase.chars
      unless valid_code?(guess)
        puts "Invalid guess, try again."
        redo
      end

      correct_pos, correct_color = feedback(guess, @secret_code)
      if correct_pos == CODE_LENGTH
        puts "You cracked the code! 🎉"
        return
      else
        puts "Correct position: #{correct_pos}, Correct color but wrong position: #{correct_color}"
      end
    end

    puts "Sorry, you ran out of turns. The code was: #{@secret_code.join}"
  end

  # Simple computer guess strategy
  def computer_guesses
    puts "Computer will try to guess your code."
    possible_colors = COLORS.dup
    previous_guess = Array.new(CODE_LENGTH) { COLORS.sample }

    MAX_TURNS.times do |turn|
      guess = previous_guess.map { |c| COLORS.sample }
      puts "Turn #{turn + 1}/#{MAX_TURNS}: Computer guesses #{guess.join}"

      correct_pos, correct_color = feedback(guess, @secret_code)
      if correct_pos == CODE_LENGTH
        puts "Computer cracked your code! 🤖"
        return
      else
        puts "Feedback -> Correct position: #{correct_pos}, Correct color but wrong position: #{correct_color}"
      end
      previous_guess = guess
    end

    puts "Computer couldn't guess your code. Well done!"
  end

  # Feedback: returns [correct_position, correct_color_wrong_position]
  def feedback(guess, code)
    temp_code = code.dup
    temp_guess = guess.dup

    # Count correct positions
    correct_pos = 0
    temp_guess.each_with_index do |c, i|
      if c == temp_code[i]
        correct_pos += 1
        temp_guess[i] = nil
        temp_code[i] = nil
      end
    end

    # Count correct colors in wrong positions
    correct_color = 0
    temp_guess.compact.each do |c|
      if temp_code.compact.include?(c)
        correct_color += 1
        temp_code[temp_code.index(c)] = nil
      end
    end

    [correct_pos, correct_color]
  end
end

# Start the game
Mastermind.new

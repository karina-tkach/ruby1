require_relative "player"
require_relative "save_manager"

class Game
  MAX_WRONG = 7

  def initialize(word = nil, correct = nil, wrong = nil, remaining = nil)
    @word = word || select_word
    @correct_letters = correct || Array.new(@word.length, "_")
    @wrong_letters = wrong || []
    @remaining_guesses = remaining || MAX_WRONG
    @player = Player.new
  end

  def play
    until game_over?
      display_status
      input = @player.get_input

      if input == "save"
        SaveManager.save_game(self)
        puts "Game saved!"
        next
      end

      process_guess(input)
    end

    finish_game
  end

  def process_guess(letter)
    if @word.include?(letter)
      update_correct_letters(letter)
    else
      @wrong_letters << letter unless @wrong_letters.include?(letter)
      @remaining_guesses -= 1
    end
  end

  def update_correct_letters(letter)
    @word.chars.each_with_index do |char, i|
      @correct_letters[i] = char if char == letter
    end
  end

  def game_over?
    @remaining_guesses == 0 || @correct_letters.join("") == @word
  end

  def finish_game
    if @correct_letters.join("") == @word
      puts "You win! The word was '#{@word}'."
      SaveManager.save_game(self)
    else
      puts "Game over... The word was '#{@word}'."
      SaveManager.save_game(self)
    end
  end

  def display_status
    puts "\nWord: " + @correct_letters.join(" ")
    puts "Wrong letters: #{@wrong_letters.join(", ")}"
    puts "Remaining guesses: #{@remaining_guesses}"
    puts "Enter a letter or type 'save' to save:"
  end

  def select_word
    words = File.readlines(File.join(__dir__, "./dictionary.txt"), chomp: true)
    valid = words.select { |w| w.length.between?(5, 12) }
    valid.sample.downcase
  end

  # Needed for SaveManager (serialization)
  attr_reader :word, :correct_letters, :wrong_letters, :remaining_guesses
end

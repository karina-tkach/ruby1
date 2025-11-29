require "yaml"

class SaveManager
  SAVE_DIR = File.join(__dir__, "../saves")

  def self.saved_games?
    Dir.exist?(SAVE_DIR) && !Dir.empty?(SAVE_DIR)
  end

  def self.save_game(game)
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
    File.open("#{SAVE_DIR}/hangman_save.yml", "w") do |file|
      data = {
        word: game.word,
        correct: game.correct_letters,
        wrong: game.wrong_letters,
        remaining: game.remaining_guesses
      }
      file.write(data.to_yaml)
    end
  end

  def self.load_game
  save_path = "#{SAVE_DIR}/hangman_save.yml"

  if File.exist?(save_path)
    begin
      data = YAML.load_file(save_path)
      return Game.new(
        data[:word],
        data[:correct],
        data[:wrong],
        data[:remaining]
      )
    rescue
      puts "Save file corrupted. Starting a new game..."
      return Game.new
    end
  else
    puts "No saved game found. Starting a new game..."
    return Game.new
  end
  end

end

require_relative "lib/game"
require_relative "lib/save_manager"

puts "H A N G M A N"
puts "1) New Game"
puts "2) Load Game"
print "> "
choice = gets.chomp

if choice == "2" && SaveManager.saved_games?
  SaveManager.load_game.play
else
  Game.new.play
end

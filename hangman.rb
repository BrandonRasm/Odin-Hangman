class Game
  def initialize
    @max_guesses = 6
    load_game_check ? load_saved_game : load_new_game
  end

  def load_game_check
    puts 'Do you want to load your game?'
    puts "No of course you don't. Loading new game..."
    false
  end

  def load_saved_game
    puts "code not done yet - can't load file"
  end

  def load_new_game
    @guesses = @max_guesses
    @mystery_word = generate_new_word
    puts @mystery_word
  end

  def generate_new_word
    loop do
      word = File.readlines('google-10000-english-no-swears.txt').sample
      return word if word.length >= 5 && word.length <= 12
    end
  end
end

game = Game.new

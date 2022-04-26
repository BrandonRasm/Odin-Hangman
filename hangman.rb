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
    @guesses_left = @max_guesses
    @mystery_word = generate_new_word
    @available_letters = ('a'..'z').to_a
    @guessed_letters = []
  end

  def generate_new_word
    loop do
      word = File.readlines('google-10000-english-no-swears.txt').sample
      return word if word.length >= 5 && word.length <= 12
    end
  end

  def play
    loop do
      if @guesses_left.zero?
        puts 'Game Over!'
        break
      end

      puts play_round
    end
  end

  def play_round
    guess = player_guess
    @guesses_left -= 1 unless correct_guess?(guess)
  end

  def player_guess
    loop do
      puts 'Guess a letter'
      guess = gets.chomp
      if guess.length == 1 && @available_letters.inclue?(guess)
        @available_letters.delete(guess)
        return guess
      end
    end
  end

  def correct_guess?(guess)
    @guessed_letters.append(guess)
    @mystery_word.inclue?(guess)
  end
end

game = Game.new
game.play

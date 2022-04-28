require 'yaml'

class Game
  def initialize
    @max_guesses = 6
    load_new_game
  end

  def load_new_game
    @guesses_left = @max_guesses
    @mystery_word = generate_new_word
    @available_letters = ('A'..'Z').to_a
    @guessed_letters = []
  end

  def generate_new_word
    loop do
      word = File.readlines('google-10000-english-no-swears.txt').sample.chomp.upcase
      return word if word.length >= 5 && word.length <= 12
    end
  end

  def play
    loop do
      if @guesses_left.zero?
        puts 'Game Over!'
        break
      end

      play_round
    end
  end

  def play_round
    guess = player_guess
    @guessed_letters.append(guess)
    @guesses_left -= 1 unless @mystery_word.include?(guess)
    display_results(@mystery_word.include?(guess))
    ask_to_save
  end

  def player_guess
    loop do
      puts 'Guess a letter'
      guess = gets.chomp.upcase
      if guess.length == 1 && @available_letters.include?(guess)
        @available_letters.delete(guess)
        return guess
      end
    end
  end

  def display_results(correct_guess)
    unless player_won?
      message = correct_guess ? 'Right!' : 'Wrong!'
      puts "You were #{message}"
      puts "guesses left #{@guesses_left}"
      puts @mystery_word.tr("^#{@guessed_letters}", '*')
      return
    end
    puts 'YOU DID IT!'
  end

  def player_won?
    word_holder = @mystery_word
    @guessed_letters.each do |letter|
      word_holder = word_holder.tr(letter, '')
    end
    @guesses_left = 0 if word_holder.empty?
    word_holder.empty?
  end

  def ask_to_save
    puts 'Do you want to save?'
    puts "Type 'Y' to save, Type anything else to decline "
    if gets.chomp == 'Y'
      file = File.open('test.yaml', 'w')
      save = YAML.dump(self)
      file.write(save)
      puts 'GAME SAVED!'
      file.close
    end
  end
end

def load_saved_game
  file = File.open('test.yaml', 'r')
  yaml_obj = file.read
  p yaml_obj
  YAML.load(yaml_obj)
end

puts 'do you want to load a new game?'
puts "type 'Y' for yes. type anything else for no"


game = (gets.chomp == 'Y') ? load_saved_game : Game.new
game.play

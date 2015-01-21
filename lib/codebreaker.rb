require "codebreaker/version"

module Codebreaker
  class Game
  	def initialize(turns = 5)
  	  @turns = turns

      @advice = true
      @players_name = ""

      @secret_key = ""
      generate_secret_key

      start
    end

    def generate_secret_key
      4.times { @secret_key += rand(1..6).to_s }
    end

    def start
      puts "Welcome to Codebreaker Game!"
      turns = @turns

      loop do
        if turns == 0
          game_over
          return
        end

        str = @advice ?  " or type 'hint' to request a hint" : ""
        puts "Enter code#{str}:"
        input = gets.chomp

        next unless valid?(input)

        if input == 'hint'
          give_hint if @advice
          next
        end

        print_answer(input)

        if input == @secret_key
          congratulate
          save(turns)
          try_again
          return
        end

        turns -= 1
      end
    end

    def game_over
      puts "Game Over!"
      try_again
    end

    def try_again
      puts "Try again? Type 'y' or any else for end game."
      input = gets.chomp
      if input == 'y'
        start
      else
        return
      end
    end

    def valid?(input)
      /^[1-6]{4}$/.match(input) || input == 'hint'
    end

    def give_hint
      @advice = false

      hint_position = rand(0..3)
      hint = Array.new(4, '*')
      hint[hint_position] = @secret_key[hint_position]

      puts hint.join
    end

    def print_answer(code)
      answer = Array.new(4, 'X')

      code.split("").each_with_index do |value, index|
        if @secret_key.include? value.to_s
          answer[index] = @secret_key[index] == value.to_s ? '+' : '-'
        end
      end

      puts answer.join
    end

    def congratulate
      puts "You win!"
    end

    def save(turns)
      puts "Enter your name:"
      name = gets.chomp

      save_to_file(name, turns, "winners.txt")
    end

    def save_to_file(name, turns, filename)
      File.open(filename, 'a') do |file|
        file.puts "#{name} won with #{turns} score."
      end
    end
  end
end

COMBINATIONS = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['spock', 'paper'],
  'spock' => ['scissors', 'rock']
}

def prompt(message)
  puts("=> #{message}\n")
end

def match_letters?(letters)
  result = ''
  COMBINATIONS.keys.each do |option|
    result = option.start_with?(letters)
    break if result
  end
  result
end

def letter_to_word(letter)
  COMBINATIONS.keys.filter { |option| option.start_with?(letter) }.join
end

def display_results(player, computer)
  if COMBINATIONS.key?(player) && COMBINATIONS[player].include?(computer)
    prompt("You won!")
  elsif player == computer
    prompt("It's a tie!")
  else
    prompt("Computer won!")
  end
end

def display_score(scoreboard)
  scoreboard.each { |k, v| prompt("The current score for #{k} is #{v}") }
end

def print_final_winner(scoreboard)
  if scoreboard[:player] == 3
    prompt("You have crushed the computer. Congratulations!")
  elsif scoreboard[:computer] == 3
    prompt("Computer has defeated you.")
  end
end

scoreboard = { player: 0, computer: 0 }

welcome_message = <<MSG
Welcome to Rock, Paper, Scissors, Spock, Lizard!
Whoever gets 3 wins first will be the grand winner.
When you respond, you may also simply enter the first letter of your choice.
Are you ready...?
MSG

prompt(welcome_message)
puts "\n"
sleep 1

loop do
  loop do
    choice = ''

    loop do
      prompt("Choose one: #{COMBINATIONS.keys.join(', ')}.")

      loop do
        choice = gets.chomp.downcase
        break unless choice == 's'
        prompt("Enter sc for scissors or sp for spock")
      end

      if match_letters?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    player_choice = letter_to_word(choice)
    computer_choice = COMBINATIONS.keys.sample

    prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")

    display_results(player_choice, computer_choice)
    prompt("\n")

    if COMBINATIONS[player_choice].include?(computer_choice)
      scoreboard[:player] += 1
    elsif COMBINATIONS[computer_choice].include?(player_choice)
      scoreboard[:computer] += 1
    end

    display_score(scoreboard)
    prompt("\n")

    print_final_winner(scoreboard)
    break if scoreboard[:player] == 3 || scoreboard[:computer] == 3
  end

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')

  scoreboard[:player] = 0
  scoreboard[:computer] = 0
end

prompt("Thank you for playing. Good bye!")

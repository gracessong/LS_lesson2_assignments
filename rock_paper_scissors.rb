VALID_CHOICES = %w(rock paper scissors spock lizard)

WIN_LOSE = [['rock', 'scissors'], ['rock', 'lizard'],
            ['paper', 'rock'], ['paper', 'spock'],
            ['scissors', 'paper'], ['scissors', 'lizard'],
            ['lizard', 'spock'], ['lizard', 'paper'],
            ['spock', 'scissors'], ['spock', 'rock']]

def display_results(player, computer)
  if WIN_LOSE.include?([player, computer])
    prompt("You won!")
  elsif WIN_LOSE.include?([computer, player])
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def match_letters?(collection, letters)
  result = ''
  collection.each do |element|
    result = element.start_with?(letters)
    break if result
  end
  result
end

player_score = 0
computer_score = 0

welcome_message = <<MSG
Welcome to Rock, Paper, Scissors, Spock, Lizard!
Whoever gets 3 wins first will be the grand winner.
Are you ready...?
MSG

prompt(welcome_message)
puts "\n"
sleep 1

loop do
  loop do
    choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")

      loop do
        choice = Kernel.gets().chomp().downcase
        break unless choice == 's'
        prompt("Enter sc for scissors or sp for spock")
      end

      if match_letters?(VALID_CHOICES, choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    player_choice = VALID_CHOICES.filter { |option| option.start_with?(choice) }
    player_choice = player_choice.join
    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")
    prompt("\n")
    display_results(player_choice, computer_choice)

    if WIN_LOSE.include?([player_choice, computer_choice])
      player_score += 1
    elsif WIN_LOSE.include?([computer_choice, player_choice])
      computer_score += 1
    end

    prompt("Your score #{player_score} : #{computer_score} Computer Score")
    prompt("\n")
    if player_score == 3
      prompt("You have crushed the computer. Congratulations!")
      break
    elsif computer_score == 3
      prompt("Computer has defeated you.")
      break
    end
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")

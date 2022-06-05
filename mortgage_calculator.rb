def prompt(msg)
  puts ">> #{msg}"
end

def number?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

prompt("Welcome to Mortgage Calculator")
prompt("------------------------------")

loan_amount = ''
annual_rate = ''
input_yrs = ''
input_mths = ''

loop do
  prompt("Enter your loan amount without $ sign: ")
  loop do
    loan_amount = gets.chomp

    break if number?(loan_amount)
    prompt("Please enter a valid number for loan amount: ")
  end

  prompt("Enter your annual percentage rate without % sign: ")
  loop do
    annual_rate = gets.chomp

    break if number?(annual_rate)
    prompt("Please enter a valid number for annual percentage rate: ")
  end

  prompt("Enter your loan duration: ")
  loop do
    prompt("years: ")
    input_yrs = gets.chomp
    prompt("months: ")
    input_mths = gets.chomp

    break if number?(input_yrs) && number?(input_mths)
    prompt("Please enter a valid number for the loan duration: ")
  end

  monthly_rate = annual_rate.to_f / 100 / 12

  duration_months = (input_yrs.to_i * 12) + (input_mths.to_i)

  monthly_payment = loan_amount.to_f * 
                    (monthly_rate / 
                    (1 - (1 + monthly_rate)**(-duration_months)))

  prompt("Calculating . . .")
  sleep 1
  prompt("")
  prompt("Your monthly interest rate is #{(monthly_rate * 100).round(2)}%")
  sleep 1
  prompt("Your loan duration is #{duration_months.round(1)} months")
  sleep 1
  prompt("You will pay $#{monthly_payment.round(2)} each month")
  sleep 1
  prompt("")

  prompt("Would you like to perform another calculation? (Y/N)")
  response = gets.chomp
  break unless response.downcase.start_with?('y')
end

prompt("Thank you for using Mortgage Calculator. Goodbye!")

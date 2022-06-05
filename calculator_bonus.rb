require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='EN')
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

# integer validation (Bonus feature #1)
def valid_number?(num)
  num.to_i.to_s == num
end

# method to validate inputs that include decimals (Bonus feature #2)
def number?(num)
  valid_number?(num) || float?(num)
end

def float?(num)
  num.to_f.to_s == num
end

prompt(messages('welcome', 'FR')) # trying French translation just for fun
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('error_invalid_name'))
  else
    break
  end
end

number1 = ''
number2 = ''

prompt(messages('welcome_name') + name)

loop do # main loop
  loop do
    prompt(messages('first_number'))
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt(messages('error_invalid_number'))
    end
  end

  loop do
    prompt(messages('second_number'))
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(messages('error_invalid_number'))
    end
  end

  prompt(messages('operator_prompt'))
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('error_operator'))
    end
  end

  def operation_to_message(op)
    message = case op
              when '1'
                messasges('operation_adding')
              when '2'
                messages('operation_subtracting')
              when '3'
                messages('operation_multiplying')
              when '4'
                messages('operation_dividing')
              end
    message
  end

  prompt("#{operation_to_message(operator)} #{messages('operation_message')}")

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end
  prompt(messages('result') + result.to_s)

  prompt(messages('another_calculation?'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt(messages('goodbye'))

require 'io/console'
require 'colorize'

def clear_screen
  system "clear" or system "cls"
end

def print_menu(menu, selected_index, screen_width)
  clear_screen

  # Cabeçalho centralizado
  header = "Desafio Nível Herói"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "|#{header.center(screen_width - 2).colorize(background: :blue)}|"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "\n"
  puts "\n"

  # Exibir menu centralizado
  menu.each_with_index do |item, index|
    if index == selected_index
      puts "|#{item.center(screen_width - 4).colorize(:light_cyan).on_light_black}|"
    else
      puts "|#{item.center(screen_width - 4)}|"
    end
  end

  puts "\n"
  puts "\n"
  puts "\n"

  puts "Use as teclas 'w' e 's' para navegar, e 'Enter' para selecionar.".center(screen_width).colorize(:green)
end

# Obtém o tamanho da tela
screen_width = `tput cols`.to_i

loop do
  # Menu
  menu = [
    "Digitar novo herói",
    "Sair"
  ]

  selected_index = 0
  print_menu(menu, selected_index, screen_width)

  loop do
    # Captura a entrada do usuário
    input = $stdin.getch

    case input
    when "\e[A", "w" # seta para cima ou "w"
      selected_index -= 1
      selected_index = menu.length - 1 if selected_index < 0
      print_menu(menu, selected_index, screen_width)
    when "\e[B", "s" # seta para baixo ou "s"
      selected_index += 1
      selected_index = 0 if selected_index >= menu.length
      print_menu(menu, selected_index, screen_width)
    when "\r" # Enter
      opcao = selected_index + 1

      case opcao
      when 1
        clear_screen
        # Solicita o nome do herói ao usuário
        puts "+" + "-" * (screen_width - 2) + "+"
        puts " Novo herói".center(screen_width - 2).colorize(background: :blue)
        puts "+" + "-" * (screen_width - 2) + "+"
        puts "\n"

        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"


        print "                                 Nome do herói: > "
        nome = gets.chomp
        puts "\n"
        xp = nil
        loop do
          print "                                 Quantidade de experiência (XP): > "
          xp_input = gets.chomp

          if xp_input.match?(/^\d+$/) # Verifica se a entrada contém apenas dígitos
            xp = xp_input.to_i
            break
          else
            puts "                                 Por favor, insira um número válido.".colorize(:red)
            puts "\n"
          end
        end



        # Exibe a mensagem com o nome do herói e seu nível
        nivel = if xp < 1000
                  "Ferro"
                elsif xp <= 2000
                  "Bronze"
                elsif xp <= 5000
                  "Prata"
                elsif xp <= 7000
                  "Ouro"
                elsif xp <= 8000
                  "Platina"
                elsif xp <= 9000
                  "Ascendente"
                elsif xp <= 10000
                  "Imortal"
                else
                  "Radiante"
                end
        puts "\n"
        puts "\n"
        puts "\n"

        # Define o texto da mensagem

        mensagem = "O Herói de nome #{nome} está no nível de #{nivel}."
        puts "+" + "=" * (screen_width - 2) + "+"
        puts "|" + mensagem.center(screen_width - 2).colorize(:light_green) + "|"
        puts "+" + "=" * (screen_width - 2) + "+"

        puts "\n"
        puts "\n"
        puts "Pressione Enter para continuar...".center(screen_width).colorize(:green)
        gets
      when 2
         clear_screen
        # Obtém o tamanho da tela
        screen_width = `tput cols`.to_i
        screen_height = `tput lines`.to_i

        # Calcula o deslocamento horizontal para centralizar a mensagem
        horizontal_start = (screen_width / 2) - ("Programa encerrado...".length / 2)

        # Calcula o deslocamento vertical para centralizar a mensagem
        vertical_start = (screen_height / 2)

        # Imprime a borda superior
        puts "+" + "-" * (screen_width - 2) + "+"

        # Imprime a mensagem de encerramento centralizada na tela
        puts "|" + "Programa encerrado...".center(screen_width - 2).colorize(background: :cyan) + "|"

        # Imprime a borda inferior
        puts "+" + "-" * (screen_width - 2) + "+"

        # Aguarda 3 segundos
        sleep(1.5)

        # Limpa a tela e encerra o programa
        clear_screen
        exit





      end
      break
    end
  end
end

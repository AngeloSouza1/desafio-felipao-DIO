require 'io/console'
require 'colorize'

def clear_screen
  system "clear" or system "cls"
end

def print_menu(menu, selected_index, screen_width, has_heroes)
  clear_screen

  # Cabeçalho centralizado
  header = "Desafio Nível Herói"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "|#{header.center(screen_width - 2).colorize(background: :blue)}|"
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "\n"

  # Exibir menu centralizado
  menu.each_with_index do |item, index|
    if index == selected_index
      puts " #{item.center(screen_width - 4).colorize(:light_cyan).on_light_black} "
    else
      puts " #{item.center(screen_width - 4)} "
    end
  end

  puts "\n"
  puts "Use as teclas 'w' e 's' para navegar, e 'Enter' para selecionar.".center(screen_width).colorize(:yellow)
end

# Função para coletar heróis
def coletar_herois(heroes, screen_width)
  clear_screen
  puts "+" + "-" * (screen_width - 2) + "+"
  puts " Heróis coletados:".center(screen_width - 2).colorize(background: :blue, color: :white)
  puts "+" + "-" * (screen_width - 2) + "+"
  puts "\n"
  puts "=" * screen_width
  heroes.each_with_index do |hero, index|
    nome_justificado = hero[:nome].ljust(20).colorize(:cyan)
    xp_justificado = hero[:xp].to_s.rjust(10).colorize(:green)
    nivel_justificado = hero[:nivel].ljust(20).colorize(:yellow)
    puts "#{index + 1}. #{nome_justificado} -    XP: #{xp_justificado}  -    Nível:    #{nivel_justificado}".center(screen_width)
  end
  puts "=" * screen_width
  puts "\nPressione Enter para voltar ao menu...".center(screen_width).colorize(:yellow)
  gets
end

# Função para classificar heróis de forma descendente pelo XP
def classificar_herois_descendente(heroes)
  heroes.sort_by! { |hero| hero[:xp] }.reverse!
end

# Obtém o tamanho da tela
screen_width = `tput cols`.to_i

# Vetor para armazenar os heróis
heroes = []

loop do
  # Menu
  menu = [
    "Digitar novo herói",
    (heroes.empty? ? "Mostrar heróis" : "Mostrar heróis (somente se houver heróis)"),
    "Sair"
  ]

  selected_index = 0
  print_menu(menu, selected_index, screen_width, !heroes.empty?)

  loop do
    # Captura a entrada do usuário
    input = $stdin.getch

    case input
    when "\e[A", "w" # seta para cima ou "w"
      selected_index -= 1
      selected_index = menu.length - 1 if selected_index < 0
      print_menu(menu, selected_index, screen_width, !heroes.empty?)
    when "\e[B", "s" # seta para baixo ou "s"
      selected_index += 1
      selected_index = 0 if selected_index >= menu.length
      print_menu(menu, selected_index, screen_width, !heroes.empty?)
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

        nome = ''
        loop do
          print "                                 Nome do herói (Máximo 20 caracteres): > "
          nome = gets.chomp.strip
          if nome.empty? || nome.length > 20
            puts "                                 O nome deve ter de 1 a 20 caracteres.".colorize(:red)
            puts "\n"
          else
            break
          end
        end
        puts "\n"
        xp = nil
        loop do
          print "                                 Quantidade de experiência (XP - Máximo 7 caracteres): > "
          xp_input = gets.chomp
          if xp_input.match?(/^\d{1,7}$/) # Verifica se a entrada contém no máximo 7 dígitos
            xp = xp_input.to_i
            break
          else
            puts "                                 Por favor, insira um número válido (no máximo 7 caracteres).".colorize(:red)
            puts "\n"
          end
        end

        # Define o nível do herói
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

        # Adiciona o herói ao vetor
        heroes << { nome: nome, xp: xp, nivel: nivel }
        puts "\n"
        puts "\n"
        puts "\n"

        # Exibe a mensagem com o nome do herói e seu nível
        mensagem = "O Herói de nome #{nome} está no nível de #{nivel}."
        puts "+" + "=" * (screen_width - 2) + "+"
        puts "|" + mensagem.center(screen_width - 2).colorize(:light_green) + "|"
        puts "+" + "=" * (screen_width - 2) + "+"

        puts "\n"
        puts "\n"
        puts "Pressione Enter para continuar...".center(screen_width).colorize(:green)
        gets
      when 2
        if !heroes.empty?
          classificar_herois_descendente(heroes)
          coletar_herois(heroes, screen_width)
        end
      when 3
        # Encerra o programa
        clear_screen
        puts "+" + "-" * (screen_width - 2) + "+"
        puts " Programa encerrado... ".center(screen_width - 2).colorize(background: :cyan) + "  "
        puts "+" + "-" * (screen_width - 2) + "+"
        sleep(1)
        clear_screen
        exit
      end
      break
    end
  end
end

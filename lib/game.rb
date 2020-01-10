module ConnectFour
  class Game
    attr_reader :players, :board, :current_player, :other_player
    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @other_player = players.shuffle
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      "#{current_player.name}: Enter a column between 0 and #{board.grid[0].length} "
    end

    def get_move(move = gets.chomp)
      move
    end

    def play
      puts ""
      puts "#{current_player.name} has been randomly chosen to go first"
      while true
        puts""
        puts board.display
        valid_move = false
        until valid_move
          puts solicit_move
          move = get_move
          digits = move =~ (/^[0-9]+$/)
          if move.nil? || digits.nil? || move.empty?
            puts "Error: no move!"
          elsif (move.to_i < 0 || board.grid[0].length <= move.to_i)
            puts "Error: invalid column!"
          else 
            move_success = board.place(move.to_i, current_player.color)
            valid_move = true if move_success
          end
        end
        if board.game_over
          puts board.display
          puts game_over_message
          return
        else
          switch_players
        end
      end
    end

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return "The game ended in a tie" if board.game_over == :draw
    end
  end
end
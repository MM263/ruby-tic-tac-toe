module TicTacToe
  class Game
    attr_reader :players, :board, :current_player, :other_player
    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @other_player = players.shuffle
    end

    def player_switch
      @current_player, @other_player = @other_player, @current_player
    end

    def solicit_move
      "#{current_player.name}: Enter a number between 1 and 9 to place a mark"
    end

    def valid_move?(move)
      if !(valid_moves.include?(move))
        return false
      elsif !(board.get_cell(*human_move_to_coordinate(move)).value.empty?)
        return false
      end
      true
    end

    def valid_moves
      ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    end

    def get_move(human_move = gets.chomp)
      while valid_move?(human_move) == false
        puts "#{current_player.name}, please enter a valid number"
        human_move = gets.chomp
      end
      human_move_to_coordinate(human_move)
    end

    def set_cell(x, y, value)
      board.get_cell(x, y).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
    end

    def game_over_message
      return "#{current_player.name} won!" if game_over == :winner
      return "The game ended in a tie" if game_over == :draw
    end

    def play
      puts "#{current_player.name} is going first"
      while true
        board.display
        puts ""
        puts solicit_move
        x, y = get_move
        set_cell(x, y, current_player.color)
        if game_over
          puts game_over_message
          board.display
          return
        else
          player_switch
        end
      end
    end

    private #!!!!!!!!!!!!!!!!!!!!!!!!!

    def draw?
      board.grid.flatten.map { |cell| cell.value  }.none_empty?
    end

    def winning_positions
      board.grid +
      board.grid.transpose +
      diagonals
    end

    def diagonals
      [
        [board.get_cell(0, 0), board.get_cell(1, 1), board.get_cell(2, 2)],
        [board.get_cell(0, 2), board.get_cell(1, 1), board.get_cell(2, 0)]
      ]
    end

    def winner?
      winning_positions.each do |winning_position|
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end

    def winning_position_values(winning_position)
      winning_position.map { |cell| cell.value  }
    end

    def human_move_to_coordinate(human_move)
      mapping = {
        "1" => [0, 0],
        "2" => [1, 0],
        "3" => [2, 0],
        "4" => [0, 1],
        "5" => [1, 1],
        "6" => [2, 1],
        "7" => [0, 2],
        "8" => [1, 2],
        "9" => [2, 2]
      }
      mapping[human_move]
    end
  end
end

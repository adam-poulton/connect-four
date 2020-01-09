module ConnectFour
  class Board
    attr_reader :grid
    def initialize(input = {})
      height = [input.fetch(:height, 6), 4].max
      width = [input.fetch(:width, 7), 4].max
      @grid = input.fetch(:grid, new_grid(height, width))
    end

    def get_cell(x, y)
      grid[y][x]
    end

    def display
      result = ""
      grid.each {|row| 
        result << row.map {|cell| 
          cell.value.empty? ? "_" : cell.value }.join(" ")
        result << "\n"
      }
      result << "\n"
      result
    end

    def place(column, value)
      row = grid.length
      while row > 0 do
        row -= 1
        if get_cell(column, row).value == ""
          set_cell(column, row, value)
          return true
        end
      end
      return false
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    private

    def set_cell(x, y, value)
      get_cell(x, y).value = value
    end

    def new_grid(height, width)
      Array.new(height) { Array.new(width) { Cell.new } }
    end

    def draw?
      grid.flatten.map { |cell| cell.value }.none_empty?
    end

    # for every direction
    #   for every coordinate
    #     check if next 3 elements in this direction exist and are equal
    def winner?
      directions = [[1,0], [1,-1], [1,1], [0,1]]
      max_x = grid[0].length
      max_y = grid.length
      directions.each do |dx, dy|
        for x in (0...max_x) do
          for y in (0...max_y) do
            last_x = x + 3 * dx
            last_y = y + 3 * dy
            if 0 <= last_x && last_x < max_x && 0 <= last_y && last_y < max_y
              val = get_cell(x, y).value
              if (!val.empty? && val == get_cell(x + dx, y + dy).value && 
                                 val == get_cell(x + 2 * dx, y + 2 * dy).value &&
                                 val == get_cell(x + 3 * dx, y + 3 * dy).value)
                return true
              end
            end
          end
        end
      end
      return false
    end
  end
end


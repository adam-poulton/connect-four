module ConnectFour
  class Board
    attr_reader :grid
    def initialize(input = {})
      height = [input.fetch(:height, 6), 4].max
      width = [input.fetch(:width, 7), 4].max
      @grid = new_grid(height, width)
    end

    def get_cell(x, y)
      grid[y][x]
    end

    def display
      result = ""
      grid.each {|row| 
        result << row.map {|value| 
          value.nil? ? "_" : value }.join(" ")
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
  end
end


require 'spec_helper.rb'
module ConnectFour
  describe Board do
    describe "#initialize" do
      it "initializes a default grid height" do
        board = Board.new
        expect(board.grid.size).to eql(6)
      end
      it "initializes a default grid width" do
        board = Board.new
        expect(board.grid[0].size).to eql(7)
      end
      it "initializes a custom grid height" do
        board = Board.new({height: 8})
        expect(board.grid.size).to eql(8)
      end
      it "initializes a custom grid width" do
        board = Board.new({width: 9})
        expect(board.grid[0].size).to eql(9)
      end
    end
    describe "#place" do
      it "value placed in an empty column drops to the bottom" do
        board = Board.new
        board.place(2, "A")
        expect(board.grid[-1][2].value).to eql("A")
      end
      it "new values do not override previous values" do
        board = Board.new
        board.place(2, "A")
        board.place(2, "B")
        expect(board.grid[-1][2].value).to eql("A")
      end
      it "value placed in an occupied column lands ontop of other values" do
        board = Board.new
        board.place(2, "A")
        board.place(2, "B")
        expect(board.grid[-2][2].value).to eql("B")
      end
      it "returns true when column was not full" do
        board = Board.new({height: 4})
        expect(board.place(2, "A")).to be true
      end
      it "returns false when column is already full" do
        board = Board.new({height: 4})
        4.times {
          board.place(2, "A")
        }
        expect(board.place(2, "B")).to be false
      end
    end

    TestCell = Struct.new(:value)
    let(:x) { TestCell.new("X") }
    let(:y) { TestCell.new("Y") }
    let(:e) { TestCell.new("") }

    describe "#game_over?" do
      it "returns :winner if winner? is true" do
        board = Board.new
        allow(board).to receive(:winner?) { true }
        expect(board.game_over).to eq :winner
      end
      it "returns :draw if winner? is false and draw? is true" do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { true }
        expect(board.game_over).to eq :draw
      end
      it "returns false if winner? is false and draw? is false" do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { false }
        expect(board.game_over).to be false
      end
      it "returns false when the board is empty" do
        grid = [[e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq false
      end
      it "returns :winner when a row has 4 objects with the same value in sequence on the bottom left" do
        grid = [[e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [x,x,x,x,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a row has 4 objects with the same value in sequence on the middle left " do
        grid = [[e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,x,x,x,x,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a column has 4 objects with the same value in sequence on the top right" do
        grid = [[e,e,e,e,e,e,x,],
                [e,e,e,e,e,e,x,],
                [e,e,e,e,e,e,x,],
                [e,e,e,e,e,e,x,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a column has 4 objects with the same value in sequence on the top left" do
        grid = [[x,e,e,e,e,e,e,],
                [x,e,e,e,e,e,e,],
                [x,e,e,e,e,e,e,],
                [x,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a diagonal has 4 objects with the same value in sequence starting top left" do
        grid = [[x,e,e,e,e,e,e,],
                [e,x,e,e,e,e,e,],
                [e,e,x,e,e,e,e,],
                [e,e,e,x,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a diagonal has 4 objects with the same value in sequence starting mid left" do
        grid = [[e,e,e,x,e,e,e,],
                [e,e,x,e,e,e,e,],
                [e,x,e,e,e,e,e,],
                [x,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a diagonal has 4 objects with the same value in sequence starting bottom left" do
        grid = [[e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,x,e,e,e,],
                [e,e,x,e,e,e,e,],
                [e,x,e,e,e,e,e,],
                [x,e,e,e,e,e,e,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :winner when a diagonal has 4 objects with the same value in sequence starting bottom right" do
        grid = [[e,e,e,e,e,e,e,],
                [e,e,e,e,e,e,e,],
                [e,e,e,x,e,e,e,],
                [e,e,e,e,x,e,e,],
                [e,e,e,e,e,x,e,],
                [e,e,e,e,e,e,x,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end
      it "returns :draw when the board is full with no connect-fours" do
        grid = [[y,x,y,x,y,x,y,],
                [y,x,y,x,y,x,y,],
                [x,y,x,y,x,y,x,],
                [x,y,x,y,x,y,x,],
                [y,x,y,x,y,x,y,],
                [y,x,y,x,y,x,y,]]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :draw
      end
    end

  end
end
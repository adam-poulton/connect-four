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
    describe "#draw?" do
      it "returns false on an empty board" do
        board = Board.new
        expect(board.draw?).to be false
      end
    end
  end
end
require 'spec_helper.rb'
module ConnectFour
  describe Cell do

    describe "#initialize" do
      it "initializes to a default value" do
        cell = Cell.new
        expect(cell.value).to eql("")
      end
      it "initializes to a given value" do
        cell = Cell.new("A")
        expect(cell.value).to eql("A")
      end
    end
  end
end
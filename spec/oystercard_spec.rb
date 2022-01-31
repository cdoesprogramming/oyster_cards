require "Oystercard"

describe Oystercard do
it {is_expected.to respond_to :balance}

  describe "#balance" do
    it "should check a card has a balance" do
      card = Oystercard.new
      expect(card.balance).to eq 0 
    end
  end
end
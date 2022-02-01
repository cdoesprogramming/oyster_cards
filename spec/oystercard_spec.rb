require "Oystercard"

describe Oystercard do
it {is_expected.to respond_to :balance}
it {is_expected.to respond_to(:top_up).with(1).argument}
  
  describe "#balance" do
    it "should check a card has a balance" do
      expect(subject.balance).to eq 0 
    end
  end

  describe "#top_up" do
    it "should top up money on an oyster card" do 
      expect{ subject.top_up(1)}.to change{ subject.balance }.by 1
    end

    it "should raise error if top up amount > 90" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      expect{ subject.top_up(1) }.to raise_error "Maximum balance #{maximum_balance} exceeded"
    end
  end

  describe "#deduct" do
    it 'should deduct money from oystercard' do
      expect{ subject.deduct(1)}.to change{ subject.balance }.by -1
    end
  end
 
  describe '#touch_in' do
    it 'allow the user to touch in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'changes the journey status of the card' do
      subject.top_up(5)
      subject.touch_in
      expect(subject.journey).to eq (true)
    end

    it 'should prevent touch in if balance too low' do
      expect { subject.touch_in }.to raise_error "Balance low!"
    end
  end

  describe '#journey' do
    it 'should confirm the user is on a journey' do
      expect(subject).to respond_to(:journey)
    end
  end

  describe '#touch_out' do
    it 'should allow the user to touch out' do
      expect(subject).to respond_to(:touch_out) 
    end

    it 'should change the journey status of the card to false' do 
      subject.touch_out
      expect(subject.journey).to eq false 
    end

    it 'should charge the user for the journey' do
      # oc = Oystercard.new
      # oc.top_up(5)
      # oc.touch_in
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end


  end

end
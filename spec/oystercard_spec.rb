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

  # describe "#deduct" do
  #   it 'should deduct money from oystercard' do
  #     expect{ subject.deduct(1)}.to change{ subject.balance }.by -1
  #   end
  # end
 
  describe '#touch_in' do
    it 'allow the user to touch in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'changes the journey status of the card' do
      subject.top_up(5)
      subject.touch_in('station')
      expect(subject.in_journey?).to eq (true)
    end

    it 'should prevent touch in if balance too low' do
      expect { subject.touch_in('station') }.to raise_error "Balance low!"
    end

    let(:station){ double :station }
    it 'should tell us what station the user has entered' do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  end

  describe '#journey' do
    it 'should confirm the user is on a journey' do
      expect(subject).to respond_to(:in_journey?)
    end
  end
  
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#touch_out' do
    it 'should allow the user to touch out' do
      expect(subject).to respond_to(:touch_out) 
    end

    it 'should change the journey status of the card to false' do 
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false 
    end

    it 'should charge the user for the journey' do
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end 

      it 'stores an exit station' do 
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end
    
  it 'has an empty list of journeys' do
    expect(subject.journeys).to be_empty   
  end

  let(:journey) { {entry_station: entry_station, exit_station: exit_station }}
  describe '#journeys' do
    it 'stores a journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey 
    end
  end
end
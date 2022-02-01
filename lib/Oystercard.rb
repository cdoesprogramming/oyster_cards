class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance
  attr_reader :journey
  attr_reader :entry_station 

  def initialize
    @balance = 0
    @journey = false 
    @entry_station = []
  end

  def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  
  def touch_in(station)
    fail "Balance low!" if @balance < MINIMUM_BALANCE 
    @entry_station << station 
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @journey = false
  end

  # def entry_station
  #   @entry_station
  # end
  
  private

  def deduct(amount)
    @balance -= amount
  end

end
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance
  attr_reader :journey

  def initialize
    @balance = 0
    @journey = false 
  end

  def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Balance low!" if @balance < MINIMUM_BALANCE 
    @journey = true
  end

  def touch_out
    self.deduct(1)
    @journey = false
  end

end
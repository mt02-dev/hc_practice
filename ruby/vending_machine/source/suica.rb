class Suica
  attr_reader :deposit

  def initialize
    @deposit = 500
  end

  def top_up_deposit(price)
    raise 'Deposit charges start at 100 yen' unless price >= 100 
    @deposit += price 
  end

  def pay(price)
    @deposit -= price
  end
end

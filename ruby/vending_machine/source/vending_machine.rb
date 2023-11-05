class VendingMachine
  JUICE_LIST = {
    'pepsi': 150,
    'monster': 230,
    'irohasu': 120
  }

  def initialize
    @stocks_list = {}
    pepsi_stock = []
    monster_stock = []
    irohasu_stock = []
    juice_keys = JUICE_LIST.keys
    juice_values = JUICE_LIST.values
    5.times do
      pepsi_stock << Juice.new(juice_keys[0], juice_values[0])
      monster_stock << Juice.new(juice_keys[1], juice_values[1])
      irohasu_stock << Juice.new(juice_keys[2], juice_values[2])
    end

    @stocks_list.store(:pepsi, pepsi_stock)
    @stocks_list.store(:monster, monster_stock)
    @stocks_list.store(:irohasu, irohasu_stock)
    @total_sales = 0

  end

  def check_stocks(juice)
    @stocks_list[:"#{juice}"].size
  end

  def check_total_sales
    @total_sales
  end

  def check_stocks_response(juice)
    check_stocks(juice).nonzero? ? "You can buy #{juice}." : "You can't buy #{juice}."
  end

  def buy_drink(juice, suica)
    raise 'Sorry, out of stock.' if check_stocks(juice).zero?

    price = JUICE_LIST[:"#{juice}"]
    raise 'Insufficient deposit' if price > suica.deposit
    suica.pay(price)
    add_sales(price)
    @stocks_list[:"#{juice}"].shift()
  end

  def display_juice_list
    in_stock = []
    @stocks_list.each { | key,value | in_stock << "#{key}:#{value.size}" if value.size.nonzero? }
    in_stock.join("\n")
  end

  def replenish_stocks(juice, num)
    num.times { @stocks_list[:"#{juice}"].push(Juice.new(juice, JUICE_LIST[:"#{juice}"])) }
  end

  private
  def add_sales(price)
    @total_sales += price
  end
end
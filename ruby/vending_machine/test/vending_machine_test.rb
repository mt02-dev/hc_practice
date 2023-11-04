require 'minitest/autorun'
require_relative '../source/juice'
require_relative '../source/suica'
require_relative '../source/vending_machine'

class TestVendingMachine < Minitest::Test
  def setup
    @suica = Suica.new
    @vending_machine = VendingMachine.new
  end

  def test_check_current_deposit
    assert_equal 500, @suica.deposit
  end

  def test_check_success_top_up_suica
    assert_equal 600, @suica.top_up_deposit(100)
  end

  def test_check_fail_top_up_suica
    e = assert_raises RuntimeError do
      @suica.top_up_deposit(99)
    end
    assert_equal 'Deposit charges start at 100 yen', e.message
  end

  def test_check_default_stocks
    assert_equal 5, @vending_machine.check_stocks('pepsi')
    assert_equal 5, @vending_machine.check_stocks('monster')
    assert_equal 5, @vending_machine.check_stocks('irohasu')
  end

  def test_direct_call_add_total
    assert_raises { @vending_machine.add_sales(100) }
  end

  def test_buy_juice
    @vending_machine.buy_drink('pepsi', @suica)
    assert_equal 4, @vending_machine.check_stocks('pepsi')
    assert_equal 350, @suica.deposit
    assert_equal 150, @vending_machine.check_total_sales
  end

  def test_fail_buy_juice_because_insufficient_deposit
    e = assert_raises RuntimeError do
        4.times { @vending_machine.buy_drink('pepsi', @suica) }
    end
    assert_equal 'Insufficient deposit', e.message
  end

  def test_fail_buy_juice_because_out_of_stock
    @suica.top_up_deposit(500)
    e = assert_raises RuntimeError do
        6.times { @vending_machine.buy_drink('pepsi', @suica) }
    end
    assert_equal 'Sorry, out of stock.', e.message
  end

  def test_drink_list
    assert_equal "pepsi:5\nmonster:5\nirohasu:5", @vending_machine.display_juice_list
  end

  def test_stocks_replenishment
    @vending_machine.replenish_stocks('pepsi', 3)
    assert_equal 8, @vending_machine.check_stocks('pepsi')
  end

  def test_check_response_can_buy
    assert_equal "You can buy pepsi.", @vending_machine.check_stocks_response('pepsi')
  end

  def test_check_response_cant_buy
    @suica.top_up_deposit(500)
    5.times { @vending_machine.buy_drink('pepsi', @suica) }
    assert_equal "You can't buy pepsi.", @vending_machine.check_stocks_response('pepsi')
  end
end
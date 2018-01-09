require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_empty_stock
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_we_have_no_cheese
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_we_can_restock_ingredients
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

end

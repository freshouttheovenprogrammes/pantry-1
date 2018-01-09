require './lib/recipe'
require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RecipeTest < Minitest::Test

  def test_it_has_a_name
    r = Recipe.new("Cheese Pizza")
    assert_equal "Cheese Pizza", r.name
  end

  def test_ingredients_start_empty
    r = Recipe.new("Cheese Pizza")

    assert_equal ({}), r.ingredients
  end

  def test_it_can_add_an_ingredient
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Flour", 500)
    r.add_ingredient("Cheese", 1500)

    assert_equal ["Flour", "Cheese"], r.ingredient_types
    assert_equal ({"Flour" => 500, "Cheese" => 1500}), r.ingredients
  end

  def test_it_tracks_amount_of_a_recipe_required
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Flour", 500)
    assert_equal 500, r.amount_required("Flour")
  end

  def test_can_add_ingredients_to_shopping_list
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    r2 = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry = Pantry.new
    pantry.add_to_shopping_list(r)
    pantry.add_to_shopping_list(r2)
    assert_equal ({"Spaghetti Noodles" => 10, "Marinara Sauce" => 10,
       "Cheese" => 25, "Flour" => 20}), pantry.shopping_list
  end

  def test_we_can_print_shopping_list
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    r2 = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry = Pantry.new
    pantry.add_to_shopping_list(r)
    pantry.add_to_shopping_list(r2)
    assert_equal ({"Spaghetti Noodles" => 10, "Marinara Sauce" => 10,
       "Cheese" => 25, "Flour" => 20}), pantry.shopping_list
    assert_equal "* Cheese: 25\n* Flour: 20\n* Marinara Sauce: 10\n* Spaghetti Noodles: 10", pantry.print_shopping_list
  end

  def test_we_can_add_to_cookbook
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry = Pantry.new
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal [r1, r2, r3], pantry.cookbook
  end

  def test_what_we_can_make
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry = Pantry.new
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)
    # require "pry"; binding.pry
    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
  end
end

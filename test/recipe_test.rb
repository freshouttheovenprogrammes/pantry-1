require './lib/recipe'
require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RecipeTest < Minitest::Test

  def test_it_has_a_name
    skip
    r = Recipe.new("Cheese Pizza")
    assert_equal "Cheese Pizza", r.name
  end

  def test_ingredients_start_empty
    skip
    r = Recipe.new("Cheese Pizza")

    assert_equal ({}), r.ingredients
  end

  def test_it_can_add_an_ingredient
    skip
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Flour", 500)
    r.add_ingredient("Cheese", 1500)

    assert_equal ["Flour", "Cheese"], r.ingredient_types
    assert_equal ({"Flour" => 500, "Cheese" => 1500}), r.ingredients
  end

  def test_it_tracks_amount_of_a_recipe_required
    skip
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
       "Cheese" => 5, "Flour" => 20}), pantry.shopping_list
  end
end

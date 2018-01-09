class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
  end

  def stock_check(ingredient)
    stock[ingredient]
  end

  def restock(ingredient, amount)
    stock[ingredient] += amount
  end

  def add_to_shopping_list(r)
    r.ingredients.reduce(shopping_list) do |list, (ingredient, amount)|
        list[ingredient] += amount
        list
      end
  end

  def print_shopping_list
    shopping_list.sort.reduce("") do |list, (ingredient, amount)|
      puts "* #{ingredient}: #{amount}"
      list += "* #{ingredient}: #{amount}\n"
    end.chomp
  end

  def add_to_cookbook(recipe)
    cookbook.push(recipe)
  end

  def check_if_has_single_ingredient(ingredient, amount)
    return true if stock[ingredient] > amount
  end

  def check_each_ingredient(recipe)
    can_make = true
    recipe.ingredients.each do |ingredient, amount|
      can_make = check_if_has_single_ingredient(ingredient, amount)
    end
    can_make
  end

  def recipes_can_make
    cookbook.map do |recipe|
      make_recipe = check_each_ingredient(recipe)
      recipe if make_recipe == true
    end.compact
  end

  def what_can_i_make
    recipes_can_make.map do |recipe|
      recipe.name
    end
  end

  def compare_what_i_have(recipe)
    recipe.ingredients.each do |ingredient, amount|
      quantity = stock[ingredient] / amount
      quantity
    end
  end

  def how_many_can_i_make
    recipes_can_make.reduce({}) do |collection, recipe|
      collection[recipe.name] = compare_what_i_have(recipe)
      collection
    end
  end


end

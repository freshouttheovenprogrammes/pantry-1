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

end

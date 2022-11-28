require_relative "ownable"

class Item
  include Ownable
  attr_reader :name, :price

  @@instances = []

  def initialize(name, price, owner=nil)
    @name = name
    @price = price
    self.owner = owner

    # Lorsqu'une instance d'élément est créée, l'instance d'élément (self) est stockée dans la variable de classe @@insntances
    @@instances << self
  end

  def label
    { name: name, price: price }
  end

  def self.all
    #　Retourne @@instances ==> Cela signifie que Item.all retourne toutes les instances d'éléments créées jusqu'à présent.
    @@instances
  end

end
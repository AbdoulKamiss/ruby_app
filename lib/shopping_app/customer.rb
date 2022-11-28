require_relative "user"
require_relative "cart"

class Customer < User
  attr_reader :cart

  def initialize(name)
    super(name) # Pour en savoir plus sur le rôle de SUPER, veuillez consulter le texte à l'adresse [https://diver.diveintocode.jp/curriculums/2360]
    @cart = Cart.new(self) # Lorsqu'une instance de client est créée, elle possède un panier dont elle est le propriétaire.
  end

end

require_relative "item_manager"
require_relative "wallet"

class User
  include ItemManager

  attr_accessor :name
  attr_reader :wallet

  def initialize(name)
    @name = name
    @wallet = Wallet.new(self) # Lorsqu'une instance de User ou une instance d'une classe héritant de User est créée, elle possède un portefeuille dont elle est le propriétaire.
  end

end

require_relative "item_manager"
require_relative "ownable"

class Cart
  include ItemManager
  include Ownable

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Remplacez la méthode Items du ItemManager, car nous voulons que les éléments du panier soient ses propres @items.
    # En effet, lorsqu'une instance de panier possède une instance d'élément, elle le stocke simplement dans ses propres @items (Cart#add) sans devoir faire transférer les droits de propriété.
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    return if owner.wallet.balance < total_amount
      self.owner.wallet.withdraw(total_amount)
      seller = items[0].owner
      seller.wallet.deposit(total_amount)

      customer = self.owner
      items.map do |item|
        item.owner = customer
      end

      items.clear
  # ## Exigence
  #   - Le prix d'achat de tous les articles contenus dans le panier (Cart#items) est transféré du portefeuille du propriétaire du panier au portefeuille du propriétaire de l'article.
  #   - Les droits de propriété de tous les éléments du contenu du panier (Cart#items) sont transférés au propriétaire du panier.
  #   - Le contenu du panier (Cart#items) doit être vide.

  # ## Conseil
  #   - Portefeuille du propriétaire du panier ==> self.owner.wallet
  #   - Portefeuille du propriétaire de l'article ==> item.owner.wallet
  #   - Que l'argent est transféré ==> ( ?) L'argent est retiré du portefeuille de ( ?) et crédité sur le portefeuille de ( ?). (et de déposer cette somme d'argent dans le portefeuille de ( ?).
  #   - L'autorité du propriétaire de l'article est transférée au propriétaire du panier ==> Réécriture du propriétaire(item.owner = ?)
  end

end

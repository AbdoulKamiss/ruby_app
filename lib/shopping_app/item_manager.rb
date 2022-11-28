# Si vous souhaitez vérifier le rôle du module, veuillez vous référer au texte à l'adresse [https://diver.diveintocode.jp/curriculums/2360].
require "kosi"
require_relative "item"

# L'inclusion de ce module vous permet de manipuler vos propres instances d'éléments.
module ItemManager
  def items # Renvoie toutes les instances d'éléments qui lui appartiennent (il en est le propriétaire).
    Item.all.select{|item| item.owner == self }
  end

  def pick_items(number, quantity) # Renvoie l'instance d'élément qu'il possède et qui correspond au numéro pour la quantité spécifiée.
    items = stock.find{|stock| stock[:number] == number }&.dig(:items)
    return if items.nil? || items.size < quantity
    items.slice(0, quantity)
  end

  def items_list # Produit l'état du stock de l'instance d'élément qu'il possède au format tableau avec les colonnes ["Numéro", "Nom de l'élément", "Montant", "Quantité"].
    kosi = Kosi::Table.new({header: %w{番号 商品名 金額 数量}}) # URL de "kosi" en Gemgile
    print kosi.render(
      stock.map do |stock|
        [
          stock[:number],
          stock[:label][:name],
          stock[:label][:price],
          stock[:items].size
        ]
      end
    )
  end

  private

  def stock # Renvoie l'état du stock de l'instance d'élément qu'il possède.
    items
      .group_by{|item| item.label } # Classifier avec une instance Item qui renvoie la même valeur dans Item#label.
      .map.with_index do |label_and_items, index|
        {
          number: index,
          label: {
            name: label_and_items[0][:name],
            price: label_and_items[0][:price],
          },
          items: label_and_items[1], # L'instance de l'élément classé est stockée dans cet élément.
        }
      end
  end

end

require_relative "shopping_app/seller"
require_relative "shopping_app/item"
require_relative "shopping_app/customer"

seller = Seller.new("DIC Store")
10.times{ Item.new("CPU", 40830, seller) }
10.times{ Item.new("Mémoire", 13880, seller) }
10.times{ Item.new("Carte-mère", 28980, seller) }
10.times{ Item.new("PSU", 8980, seller) }
10.times{ Item.new("Boîtier PC", 8727, seller) }
10.times{ Item.new("3.5 HDD", 10980, seller) }
10.times{ Item.new("2.5 SSD", 13370, seller) }
10.times{ Item.new("M.2 SSD", 12980, seller) }
10.times{ Item.new("Refroidisseur de CPU", 13400, seller) }
10.times{ Item.new("Carte graphique", 23800, seller) }

puts "🤖 Quel est votre nom ?"
customer = Customer.new(gets.chomp)

puts "🏧 Entrez le montant à débiter sur le portefeuille."
customer.wallet.deposit(gets.chomp.to_i)

puts "🛍️ Commencer les achats"
end_shopping = false
while !end_shopping do
  puts "📜 Liste des produits."
  seller.items_list

  puts "️️⛏ Veuillez entrer le numéro du produit"
  number = gets.to_i

  puts "⛏ Veuillez entrer la quantité de marchandises"
  quantity = gets.to_i

  items = seller.pick_items(number, quantity)

  items&.each{|item| customer.cart.add(item) }

  puts "🛒 Contenu du panier."
  customer.cart.items_list
  puts "🤑 Montant total: #{customer.cart.total_amount}"

  puts "😭 Tu veux finir tes courses ?(yes/no)"
  end_shopping = gets.chomp == "yes"
end

puts "💸 Voulez-vous finaliser l'achat ?(yes/no)"
customer.cart.check_out if gets.chomp == "yes"

puts "୨୧┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈Résultat┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈୨୧"
puts "️🛍️ Propriété de ️#{customer.name}"
customer.items_list
puts "😱👛 Solde du portefeuille de #{customer.name}: #{customer.wallet.balance}"

puts "📦 État des stocks de #{seller.name}"
seller.items_list
puts "😻👛 Solde du portefeuille de #{seller.name}: #{seller.wallet.balance}"

puts "🛒 Contenu du panier."
customer.cart.items_list
puts "🌚 Montant total: #{customer.cart.total_amount}"

puts "🎉 Fin"

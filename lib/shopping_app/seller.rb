require_relative "user"

class Seller < User
  def initialize(name)
    super(name) # Pour en savoir plus sur le rôle de SUPER, veuillez consulter le texte à l'adresse [https://diver.diveintocode.jp/curriculums/2360].
  end

end

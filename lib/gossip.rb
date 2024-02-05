require 'pry'
require 'csv'

class Gossip
  attr_accessor :author, :content

  @@file_path = './db/gossip.csv'

  def initialize(author, content)
    @author = author
    @content = content
  end

  # sauvgarder le gossip dans la bdd
  def save
    CSV.open(@@file_path, 'ab') do |csv|
      csv << [ @author , @content ]
    end
  end

  # Lire la BDD et retourner un array de Hashes
  def self.all
    all_gossips = []
    CSV.foreach(@@file_path) do |csv|
        all_gossips  << Gossip.new(csv[0],csv[1])
    end
    return all_gossips
  end

  # trouver un gossip par son identifiant
  def self.find(id)
    return self.all[id]
  end

  # mise à jour du fichier Csv
  def self.update_csv(csv_array)
    CSV.open(@@file_path, 'wb') do |csv|
      csv_array.each{|gossip| csv << gossip}
    end
  end

  # mise à jour du gossip
  def self.update(id, author, content)
    # lire le csv
    csv_array = CSV.read(@@file_path)
    # update de l'Array
    csv_array.each_with_index do |gossip, index| 
      if id == index
        csv_array[index][0] = author
        csv_array[index][1] = content
      end
    end
    # mise à jour du fichier
    self.update_csv(csv_array)
  end

  def self.delete(id)
    csv_array = self.all
    # suppression du gossip
    updated_array = csv_array.filter.with_index do |gossip, index|
      index != id
    end
     # mise à jour du fichier
     self.update_csv(updated_array)

     # TODO: delete les commentaires associés
  end
end


# _____ TESTS
# gossip = Gossip.new("Annie","Mon potin,'lol' test update")
# gossip = Gossip.find(0)

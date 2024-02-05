require 'pry'
require 'csv'

class Gossip
  attr_accessor :author, :content, :gossip_array

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

  # créer un array de hashes Gossips depuis la DB
  def self.all
    all_gossip = []
    CSV.foreach(@@file_path) do |line|
        all_gossip  << Gossip.new(line[0],line[1])
    end
    return all_gossip
  end

  # trouver un gossip par son identifiant
  def self.find(id)
    return self.all[id]
  end

  # mise à jour du gossip
  def self.update(id, author, content)
    i = 0
    CSV.open(@@file_path, 'wb') do |csv|
      csv.replace([ author , content ]) if i == id
      i +=1
    end
    binding.pry
  end
end

# _____ TESTS
# gossip = Gossip.new("Annie","Mon potin,'lol' test update")
# gossip = Gossip.find(0)
Gossip.update(9, "Anniex","Mon potin,'lol' test update : ok")

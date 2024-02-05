require 'pry'
require 'csv'

class Comment
  attr_accessor :gossip_id, :author, :content

  @@file_path = './db/comment.csv'

  def initialize(gossip_id, author, content)
    @gossip_id = gossip_id
    @author = author
    @content = content
  end

  # sauvgarder le comment dans la bdd
  def save
    CSV.open(@@file_path, 'ab') do |csv|
      csv << [ @gossip_id, @author , @content ]
    end
  end

  # lire la BDD et retourner un Array de Hashs Comments
  def self.all
    all_comments = []
    CSV.foreach(@@file_path) do |csv|
      all_comments  << Comment.new(csv[0],csv[1],csv[2])
    end
    return all_comments
  end

  # trouver tous les commantaires d'un gossip
  def self.find(gossip_id)
    gossip_comments = self.all.filter.with_index do |comment, i| 
      comment if comment.gossip_id.to_i == gossip_id
    end
    return gossip_comments
  end

  # mise à jour du fichier Csv
  def self.update_csv(csv_array)
    CSV.open(@@file_path, 'wb') do |csv|
      csv_array.each{|comment| csv << comment}
    end
  end

  def self.delete(id)
    csv_array = self.all
    # suppression du gossip
    updated_array = csv_array.filter.with_index do |comment, index|
      index != id
    end
     # mise à jour du fichier
     self.update_csv(updated_array)
  end
end


# _____ TESTS
# commments = Comment.find(0)


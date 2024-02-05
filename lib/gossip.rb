# require 'pry'
require 'csv'
class Gossip
  attr_accessor :author, :content, :gossip_array

  @@file_path = './db/gossip.csv'

  def initialize(author, content)
    @author = author
    @content = content
    @gossip_array = [@author,@content]
  end

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

  # def self.delete(id)
  #   File.open(@file_path+'_temp', 'w') do |out_file|
  #     File.foreach(@file_path).with_index do |line, line_index|
  #       out_file.puts line unles line_index == id
  #     end
  #   end
  #   File.delete(@file_path)
  #   File.rename(@file_path+'_temp', @file_path)
  # end
end

# gossip = Gossip.new("Annie","Mon potin,'lol'")
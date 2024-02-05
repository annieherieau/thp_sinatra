class Gossip
  attr_accessor :author, :content, :gossip_array

  @@file_path = './db/gossip.csv'

  def initialize(author="", content="")
    @author = author
    @content = content
    @gossip_array = [@author,@content]
  end

  def save
    File.open(@@file_path, 'a') do |f|
      f.write(to_csv)
      f.close
    end
  end

  # formater en CVS
  def to_csv
    output_string = CSV.generate do |csv|
      csv << @gossip_array
    end
    return output_string
  end

  # créer un array de hashes Gossips depuis la DB
  def self.all
    all_gossip = []
    CSV.foreach(@@file_path) do |row|
        all_gossip  << Gossip.new(row[0],row[1])
    end
    return all_gossip
  end

  def self.delete(id)
    File.open(@file_path+'_temp', 'w') do |out_file|
      File.foreach(@file_path).with_index do |line, line_index|
        out_file.puts line unles line_index == id
      end
    end
    File.delete(@file_path)
    File.rename(@file_path+'_temp', @file_path)
  end
end

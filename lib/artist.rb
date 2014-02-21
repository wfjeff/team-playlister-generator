class Artist < Sequel::Model
    def self.create_table
    Sequel::Migrator.run(DB, 'db/migrations')
  end

  def self.drop_table
    Sequel::Migrator.run(DB, 'db/migrations', :target => 0)
  end

  def self.find_by_name(name)
    self.find(:name => name)
  end

  def self.new_from_db(id)
    self.find(:id => id)
  end

  def insert
    #add artist
  end
  
  def update
    #change artist name and save
  end

  def save
  end

  def songs
    #find songs where artist_id = self.id
  end

  def genres
    #find genre id and then object of songs with artist_id = self.id
  end
end
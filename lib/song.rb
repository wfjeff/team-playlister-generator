class Song < Sequel::Model

  def self.create_table
    Sequel::Migrator.run(DB, 'db/migrations')
  end

  def self.drop_table
    Sequel::Migrator.run(DB, 'db/migrations', :target => 0)
  end

  def self.find_by_name(name)
    self.find(:name => name)
  end

  def self.new_from_db(row)
    self.new.tap do |song|
      song.title = row[0]
      song.artist = row[1]
      song.genre = row[2]
      song.save
    end
  end

  def self.get_songs
    Parser.parse.each do |songinfo|
      self.new_from_db(songinfo)
    end
  end
end
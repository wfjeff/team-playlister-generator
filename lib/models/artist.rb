class Artist < Sequel::Model

  ARTISTS = []

  def initialize
    ARTISTS << self
  end

  def all
    ARTISTS
  end

  def url
    self.name.downcase.gsub(" ", "_")
  end

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

  def songs
    song[:artist_id => self.id]
  end

  def genres
    song[:artist_id => self.id].collect do |song|
      song.genre.name
    end
  end
end
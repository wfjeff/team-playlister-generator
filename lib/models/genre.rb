class Genre < Sequel::Model

  GENRES = []

  def initialize
    GENRES << self
  end

  def all
    GENRES
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

  def self.new_from_db(id)
    self.find(:id => id)
  end

  def self.find_by_name(name)
    self.find(:name => name)
  end
end
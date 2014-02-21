class Genre < Sequel::Model
  def self.create_table
    Sequel::Migrator.run(DB, 'db/migrations')
  end

  def self.drop_table
    Sequel::Migrator.run(DB, 'db/migrations', :target => 0)
  end

  def insert
    self.save
  end

  def update
    self.
  end

  def save
    if self.id


  def self.new_from_db(id)
    self.find(:id => id)
  end

  def self.find_by_name(name)
    self.find(:name => name)
  end
end
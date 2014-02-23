class Artist 

 
  extend DBable::ClassMethods
  include DBable::InstanceMethods

  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY ASC",
    :name => "TEXT"
  }
  
  attr_accessor *ATTRIBUTES.keys

  def self.attributes
    ATTRIBUTES
  end

  def songs
    Song[:artist_id => self.id]
  end

  def genres
    Song[:artist_id => self.id].collect do |song|
      song.genre
    end.uniq
  end
end
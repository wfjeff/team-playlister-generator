class Genre   

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

  def self.all_in_order
    all.sort do |a,b|
      a.songs.length <=> b.songs.length
    end.reverse
  end

  def songs
    Song[:genre_id => self.id]
  end

  def artists
    songs.collect{|s| s.artist}.uniq
  end 
  
end
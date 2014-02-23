class Song 
  extend DBable::ClassMethods
  include DBable::InstanceMethods

  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY ASC",
    :name => "TEXT",
    :artist_id => "INTEGER",
    :genre_id => "INTEGER"
  }
  
  attr_accessor *ATTRIBUTES.keys

  def self.attributes
    ATTRIBUTES
  end

  def url
    self.name.downcase.gsub(" ", "_") << ".html"
  end

  def artist
    Artist[:id => artist_id][0]
  end

  def artist=(artist)
    if Artist[:name => artist].empty?
      artist_id = Artist.new({:name => artist}).tap{ |a|
        a.save
      }.id
    else
      artist_id = Artist[:name => artist][0][0]
    end
    save
  end

  def genre=(genre)
    if Genre[:name => genre].empty?
      genre_id = Genre.new({:name => genre}).tap{ |g|
        g.save
      }.id
    else
      genre_id = Genre[:name => genre][0][0]
    end
    save
  end

  def genre
    Genre[:id => genre_id][0]
  end

end
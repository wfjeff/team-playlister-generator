class Parser
  def initialize
    @path = 'playlistersite/db/data'
  end

  def files
    Dir.entries("#{@path}").collect do |filename|
      filename unless /^\./.match(filename)
    end.compact
  end

  def parse_filename(filename)
    parsed = []
    parsedartist = filename.split(" - ")[0]
    parsedtitle = parsedartist[1].to_s.split(" [")[0]
    parsedgenre = parsedtitle[1].to_s.chomp('].mp3')
    parsed << parsedartist << parsedtitle << parsedgenre
    parsed
  end


  def build_song(name, artist, genre)
    song = Song.new
    song.name = name

    if Artist.find_by_name(artist)
      song.artist = Artist.find_by_name(artist)
    else 
      song.artist = Artist.new
      song.artist.name = artist
    end

    if Genre.find_by_name(genre)
      song.genre = Genre.find_by_name(genre)
    else
      song.genre = Genre.new
      song.genre.name = genre
    end

    song
  end

  def parse
    files.each do |filename|
      parsed = parse_filename(filename)
      parsed.collect do |parsednames|
        build_song(parsednames[0], parsednames[1], parsednames[2])
      end
    end
  end
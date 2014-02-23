class Generator
  def self.generate_site
    Artist.create_table
    Song.create_table
    Genre.create_table

    self.populate_db
    generate_artist_index
    generate_genre_index
    generate_artist_pages
    generate_genre_pages
    generate_song_pages

  end

  def self.populate_db
    @parsed_files = Parser.new("#{Dir.pwd}/lib/fixtures/data").parse
    @parsed_files.collect{|file| file[0]}.uniq.each do |artist|
      Artist.new({:name => artist}).save
    end
    @parsed_files.collect{|file| file[2]}.uniq.each do |genre|
      Genre.new({:name => genre}).save
    end
    @parsed_files.each do |song|
      Song.new({:name => song[1], :genre_id => Genre[:name => song[2]][0].id, :artist_id => Artist[:name => song[0]][0].id}).save
    end
  end
    

  def self.generate_artist_index
    template = ERB.new(File.open('lib/templates/artists.html.erb').read)
    File.write('./_site/artists.html', template.result(binding))
  end

  def self.generate_genre_index
    template = ERB.new(File.open('lib/templates/genres.html.erb').read)
    File.write('./_site/genres.html', template.result(binding))
  end

  def self.generate_genre_pages
    template = ERB.new(File.open('lib/templates/genre_page.html.erb').read)
    Genre.all.each do |genre|
      File.write("./_site/genres/#{genre.url}", template.result(binding))
    end
  end  

  def self.generate_artist_pages
    template = ERB.new(File.open('lib/templates/artist_page.html.erb').read)
    Artist.all.each do |artist|
      File.write("./_site/artists/#{artist.url}", template.result(binding))
    end
  end

  def self.generate_song_pages
    template = ERB.new(File.open('lib/templates/song_page.html.erb').read)
    Song.all.each do |song|
      File.write("./_site/songs/#{song.url}", template.result(binding))
    end
  end

end
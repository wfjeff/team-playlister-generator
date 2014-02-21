describe "Song class"
  before(:each) do 
    @song = Song.new
    @id = 1
    @song.name = "Party in the USA"
    @song.artist_id = 1
    @song.genre_id = 1

    @genre = Genre.new
    @id = 1
    @genre.name = "pop"
    
    @artist = Artist.new
    @id = 1
    @artist.name = "Miley"
  end
  it "can create a table" do
    Song.create_table
    # expect(DB[:conn].execute(table_check_sql)[0]).to eq(['songs'])
  end

  it "can drop a table" do
    Song.create_table
    # expect(DB[:conn].execute(table_check_sql)[0]).to be_nil
  end

  it "initializes correctly" do 
    expect(@song).to be_an_instance_of(Song)
  end

  it "has a name" do
    expect(@song.name).to eq("Party in the USA") 
  end

  it "can initalize parsed filenames as Song instances" do
    @song.get_songs
    expect(@song.all.length).to eq(Parser.files.length)
  end

  it "knows its artist" do 
    expect(@song.artist).to eq(miley)
  end

  it "can determine song genres" do 
    expect(@song.genre).to eq(pop)
  end
end
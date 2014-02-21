describe "Song class"
  before(:each) {@song = Song.new}
  it "can create a table" do
    Song.create_table
    expect(DB[:conn].execute(table_check_sql)[0]).to eq(['songs'])
  end

  it "can drop a table" do
    Song.create_table
    expect(DB[:conn].execute(table_check_sql)[0]).to be_nil
  end

  it "initializes correctly" do 
    expect(@song).to be_an_instance_of(Song)
  end

  it "has a name" do
    @song.name = "Party in the USA"
    expect(@song.name).to eq("Party in the USA") 
  end

  it "can determine song artists" do 
  end

  it "can determine song genres" do 
  end

end
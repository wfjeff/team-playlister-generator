describe Parser
  before(:each) do 
    let(:parser){Parser.new}
  end

  it "initializes correctly" do 
    expect(parser).to be_an_instance_of(Parser)
  end

  it "has a path" do 
    # expect(parser.path).to eq(INSERT PATH)
  end

  it "can determine song genres" do 
  end

end
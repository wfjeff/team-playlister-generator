require 'spec_helper'
describe Parser do
  before(:each) do 
    let(:parser){Parser.new('spec/fixtures/data')}
    let(:filename){'A$AP Rocky - Peso [dance].mp3'}
  end

  describe "#initialize" do
    it "initializes a new instance of the Parser class" do 
      expect(parser).to be_an_instance_of(Parser)
    end
  end

  describe "#path" do
    it "has a path" do 
      expect(parser.path).to eq('spec/fixtures/data')
    end
  end

  describe "#parse_filename" do
    it "parses a filename" do 
      parsed_filename = parser.parse_filename(filename)
      expect(parsed_filename).to eq(["A$AP Rocky", "Peso", "dance"])
    end
  end

  describe "#files" do
    it "accesses the filenames and returns them as an array of strings" do 
      expect(parser.files).to eq(['A$AP Rocky - Peso [dance].mp3'])
    end
  end

  describe "#parse" do
    it "returns an embedded array of all parsed files in the path" do
      expect(parser.parse).to eq([['A$AP Rocky - Peso [dance].mp3']])
    end
  end
end
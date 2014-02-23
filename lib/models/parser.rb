class Parser
  attr_accessor :path
  def initialize(path)
    @path = path
  end

  def files
    Dir.entries("#{self.path}").collect do |filename|
      filename unless /^\./.match(filename)
    end.compact
  end

  def parse_filename(filename)
    filename.gsub("].mp3","").gsub(" ["," - ").split(" - ")
  end

  def parse
    files.collect do |filename|
      parsed = parse_filename(filename)
    end
  end
  
end
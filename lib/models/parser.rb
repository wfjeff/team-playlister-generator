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
    parsed = []
    parsedartist = filename.split(" - ")[0]
    parsedtitle = parsedartist[1].to_s.split(" [")[0]
    parsedgenre = parsedtitle[1].to_s.chomp('].mp3')
    parsed << parsedartist << parsedtitle << parsedgenre
    parsed
  end

  def parse
    files.collect do |filename|
      parsed = parse_filename(filename)
    end
  end
end
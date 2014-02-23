require 'sqlite3'
require 'erb'
require 'pry'

DB = {:conn => SQLite3::Database.new(":memory:")}

require_relative "../lib/models/generator"
require_relative "../lib/concerns/dbable.rb"
require_relative '../lib/models/artist'
require_relative '../lib/models/song'
require_relative '../lib/models/genre'
require_relative '../lib/models/parser'

Song.create_table
Genre.create_table
Artist.create_table
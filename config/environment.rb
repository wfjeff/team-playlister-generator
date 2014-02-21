require 'sqlite3'
require 'sequel'
require 'pry'
require 'pry-nav'

Sequel.extension :migration, :core_extensions
Sequel::Migrator.run(Sequel.sqlite, 'db/migrations')
# Sequel::Model.db=":memory:"

require_relative '../lib/models/artist'
require_relative '../lib/models/song'
require_relative '../lib/models/genre'
require_relative '../lib/models/parser'

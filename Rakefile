require './utils/language'
require './utils/config'

require 'active_record'

task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end
 
task :environment do
  # set up the database
  require 'utils/database'
end
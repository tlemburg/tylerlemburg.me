require 'active_record'

if ENV['RACK_ENV'] == 'production'
  ActiveRecord::Base.establish_connection(ENV['CLEARDB_DATABASE_URL'].sub('mysql://', 'mysql2://'))
else
  ActiveRecord::Base.establish_connection({
      :adapter => CONFIG["db"]["adapter"],
      :host => CONFIG["db"]["host"],
      :username => CONFIG["db"]["username"],
      :password => CONFIG["db"]["password"],
      :database => CONFIG["db"]["database"]
  })
end
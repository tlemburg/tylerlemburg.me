require './utils/language'
# load the config file
require './utils/config'

# set up the database connection
require 'utils/database'

require 'sinatra'
require 'app'

run Rack::URLMap.new({
  "/" => Public,
  "/admin" => Protected
})

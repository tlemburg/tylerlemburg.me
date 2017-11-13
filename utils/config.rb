ROOT = File.expand_path(File.dirname(__FILE__)) << '/..'
$LOAD_PATH.unshift(ROOT)

require 'json'

config = {
  "db" => {
    "adapter" => 'mysql2',
    "host" => 'localhost',
    "username" => 'root',
    "password" => '',
    "database" => 'tylerlemburg'
  }
}

CONFIG = config
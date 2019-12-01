require "pry"
require "rest-client"
require "yaml"
require "pry-nav"

PAY = YAML.load_file("data/payloads.yml")

HEAD = YAML.load_file("data/headers.yml")

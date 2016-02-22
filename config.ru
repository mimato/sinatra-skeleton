require 'dotenv'
Dotenv.load

root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
run App.new

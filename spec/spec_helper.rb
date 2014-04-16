require 'rubygems'
require 'bundler/setup'

require 'yaml'
require 'crack'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mingle_party'

RSpec.configure do |config|
  # some (optional) config here
end

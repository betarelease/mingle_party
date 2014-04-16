require 'httparty'
require 'crack'
require 'rexml/document'

require 'cards'
require 'murmurs'
require 'users'

class MingleParty
  include HTTParty

  include Cards
  include Murmurs
  include Users

  def initialize
    @config = YAML.load(File.read("./config.yml")).first
    @uri = "#{@config['host']}/api/v2/projects/#{@config['project']}"
    auth = { username: @config['username'], password: @config['password'] }
    @auth_options = { :basic_auth => auth }
  end
end

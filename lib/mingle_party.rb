require 'httparty'
require 'crack'

class MingleParty
  include HTTParty

  def initialize
    config = YAML.load(File.read("./config.yml")).first
    @uri = "#{config['host']}/api/v2/projects/#{config['project']}"
    auth = { username: config['username'], password: config['password'] }
    @auth_options = { :basic_auth => auth }
  end
  
  def create_card(name, card_type)
    options = @auth_options.merge({ query: {'card[name]' =>  name, 'card[card_type_name]' => card_type } })
    response = self.class.post("#{@uri}/cards.xml", @auth_options)
  end

  def change_card_status(number, status)
    options = @auth_options.merge({ query: { 'card[properties[][name]' => 'status', 'card[properties][][value]' =>  status } })
    response  = self.class.put( "#{@uri}/cards/#{number}.xml", @auth_options )
  end

  def fetch_card(number)    
    response = self.class.get( "#{@uri}/cards/#{number}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

  def murmur(message, command)
    options = @auth_options.merge( { query:  { "#{command}".to_sym =>  message } } )
    response  = self.class.post( "#{@uri}/murmurs.xml", options )
  end
  
end

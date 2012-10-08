require 'httparty'
require 'crack'

class MingleParty
  include HTTParty

  def initialize(host, username, password, project)
    @uri = "#{host}/api/v2/projects/#{project}"
    @auth = { :username => username, :password => password }
    @auth_options = { :basic_auth => @auth }
  end

  def get(number)    
    response = self.class.get( "#{@uri}/cards/#{number}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end
  
  def put(number, status)
    options = @auth_options.merge { :query => { 'card[properties[][name]' => 'status', 'card[properties][][value]' => status } }
    response  = self.class.put( "#{@uri}/cards/#{number}.xml", options )
  end
  
  def post(message, command)
    options = @auth_options.merge { :query => { command => message } } 
    response  = self.class.post( "#{@uri}/murmurs.xml", options )
  end
end

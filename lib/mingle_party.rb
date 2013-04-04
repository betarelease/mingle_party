require 'httparty'
require 'crack'
require 'rexml/document'

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
    response = self.class.post("#{@uri}/cards.xml", options)
  end

  def change_card_status(number, status)
    options = @auth_options.merge({ query: { 'card[properties[][name]' => 'status', 'card[properties][][value]' =>  status } })
    response = self.class.put( "#{@uri}/cards/#{number}.xml", options )
  end

  def fetch_card(number)
    response = self.class.get( "#{@uri}/cards/#{number}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

  def fetch_cards
    response = self.class.get( "#{@uri}/cards.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

=begin
  def delete_card(number)
    self.class.delete( "#{@uri}/cards/#{number}")
  end

  def delete_cards
    response = fetch_cards
    response['cards'].each{|card| delete_card(card['number'].to_i)}
    response.each {|key, value| puts "#{key}" }
  end
=end

  def murmur(message, command)
    options = @auth_options.merge( { query:  { "#{command}".to_sym =>  message } } )
    response = self.class.post( "#{@uri}/murmurs.xml", options )
  end

  def create_user(user)
    options = @auth_options.merge({ query: { 'user[name]' =>  user[:name], 'user[login]' => user[:login],
                                      'user[email]' => user[:email], 'user[admin]' => user[:admin],
                                      'user[password]' => user[:password],
                                      'user[password_confirmation]' => user[:password_confirmation]} })
    self.class.post("#{@uri}/users.xml", options)
  end

  def fetch_users
    response = self.class.get( "#{@uri}/users.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

  def fetch_user(id)
    response = self.class.get( "#{@uri}/users/#{id}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end
end

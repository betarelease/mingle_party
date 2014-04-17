class Cards
  include HttpApi

  def initialize
    @uri, @auth_options = setup
  end

  def create(name, card_type)
    options = @auth_options.merge({ query: {'card[name]' =>  name, 'card[card_type_name]' => card_type } })
    response = HTTParty.post("#{@uri}/cards.xml", options)
  end

  def change_status(number, status)
    options = @auth_options.merge({ query: { 'card[properties[][name]' => 'status', 'card[properties][][value]' =>  status } })
    response = HTTParty.put( "#{@uri}/cards/#{number}.xml", options )
  end

  def find(number)
    response = HTTParty.get( "#{@uri}/cards/#{number}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

  def all
    response = HTTParty.get( "#{@uri}/cards.xml", @auth_options )
    Crack::XML.parse( response.body )["cards"]
  end

end

module Cards

  def create_card(name, card_type)
    options = @auth_options.merge({ query: {'card[name]' =>  name, 'card[card_type_name]' => card_type } })
    response = self.class.post("#{@uri}/cards.xml", options)
  end

  def change_card_status(number, status)
    options = @auth_options.merge({ query: { 'card[properties[][name]' => 'status', 'card[properties][][value]' =>  status } })
    response = self.class.put( "#{@uri}/cards/#{number}.xml", options )
  end

  def card(number)
    response = self.class.get( "#{@uri}/cards/#{number}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

  def cards
    response = self.class.get( "#{@uri}/cards.xml", @auth_options )
    Crack::XML.parse( response.body )["cards"]
  end

end

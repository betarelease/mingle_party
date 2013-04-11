module Murmurs

  def murmurs
    response = self.class.get( "#{@uri}/murmurs.xml", @auth_options )
    Crack::XML.parse( response.body )["murmurs"]
  end

  def murmur(message)
    options = @auth_options.merge( { query:  { "murmur[body]" =>  message } } )
    response = self.class.post( "#{@uri}/murmurs.xml", options )
  end
  
end
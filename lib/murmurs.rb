class Murmurs
  include HttpApi

  def initialize
    @uri, @auth_options = setup
  end

  def all
    response = HTTParty.get( "#{@uri}/murmurs.xml", @auth_options )
    Crack::XML.parse( response.body )["murmurs"]
  end

  def mutter(message)
    options = @auth_options.merge( { query:  { "murmur[body]" =>  message } } )
    response = HTTParty.post( "#{@uri}/murmurs.xml", options )
  end

end

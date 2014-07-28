class Attachments
  include HttpApi

  def initialize
    @uri, @auth_options = setup
  end

  def attach(card_number, filename)
    options = @auth_options.merge({:headers => {"Content-Type" => 'multipart/form-data'} })
    response = HTTMultiParty.post( "#{@uri}/cards/#{card_number}/attachments.xml", options.merge({:query => { :file => File.new(filename) }}) )
  end

end

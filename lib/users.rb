module Users

  def create_user(user)
    options = @auth_options.merge({ query: { 'user[name]' =>  user[:name], 'user[login]' => user[:login],
                                      'user[email]' => user[:email], 'user[admin]' => user[:admin],
                                      'user[password]' => user[:password],
                                      'user[password_confirmation]' => user[:password_confirmation]} })
    self.class.post("#{@uri}/users.xml", options)
  end

  def users
    response = self.class.get( "#{@uri}/users.xml", @auth_options )
    Crack::XML.parse( response.body )["projects_members"]
  end

  def user(id)
    response = self.class.get( "#{@uri}/users/#{id}.xml", @auth_options )
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

end
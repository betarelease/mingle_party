class Users
  include HttpApi

  def initialize
    @uri, @auth_options = setup
  end

  def create(user)
    options = @auth_options.merge({ query: { 'user[name]' =>  user[:name], 'user[login]' => user[:login],
                                      'user[email]' => user[:email], 'user[admin]' => user[:admin],
                                      'user[password]' => user[:password],
                                      'user[password_confirmation]' => user[:password_confirmation]} })
    HTTParty.post("#{@uri}/users.xml", options)
  end

  def all
    response = HTTParty.get( "#{@uri}/users.xml", @auth_options )
    Crack::XML.parse( response.body )["projects_members"]
  end

  def find(id)
    response = HTTParty.get( "#{@uri}/users/#{id}.xml", @auth_options )
    Crack::XML.parse( response.body )
  end

end

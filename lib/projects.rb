class Projects
  include HttpApi

  def initialize
    @uri, @auth_options = setup
  end

  def all
    uri = "#{@config['host']}/api/v2"
    response = HTTParty.get( "#{uri}/projects.xml", @auth_options )
    Crack::XML.parse( response.body )["projects"]
  end

  def events_for(project)
    uri = "#{@uri}/projects/#{project}/feeds/events.xml"
    response = HTTParty.get( "#{uri}", @auth_options )
    Crack::XML.parse( response.body )["events"]
  end
end

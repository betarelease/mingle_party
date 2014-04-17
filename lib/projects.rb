module Projects

  def projects
    uri = "#{@config['host']}/api/v2"
    response = self.class.get( "#{uri}/projects.xml", @auth_options )
    Crack::XML.parse( response.body )["projects"]
  end

  def events_for(project)
    uri = "#{@uri}/projects/#{project}/feeds/events.xml"
    response = self.class.get( "#{uri}", @auth_options )
    Crack::XML.parse( response.body )["events"]
  end
end

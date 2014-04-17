module HttpApi

  include HTTParty

  def setup
    config = YAML.load(File.read("./config.yml")).first
    uri = "#{config['host']}/api/v2/projects/#{config['project']}"
    auth = { username: config['username'], password: config['password'] }
    auth_options = { :basic_auth => auth }
    [uri, auth_options]
  end

end

require 'spec_helper'

describe MingleParty do
  
  before :all do
    @config = YAML.load(File.read("./config.yml")).first
    @host = @config['host']
    @username = @config['username']
    @password = @config['password']
    @project =  @config['project']
  end
  
  it "should find card" do
    mingle = MingleParty.new(host, username, password, project)
    card = mingle.get(13)

    card['card']['properties'].first['value'].should =~ /done/
    card['card']['name'].should =~ /card 13/
    card['card']['description'].should == nil
  end

  it "should change card status to done" do
    mingle = MingleParty.new(host, username, password, project)
    card = mingle.put(11, "done")

    card['card']['name'].should =~ /card 11/
    card['card']['properties'].first['value'].should =~ /done/
  end

  it "should murmur about its happiness" do
    mingle = MingleParty.new(host, username, password, project)
    murmur = mingle.post('happy to mingle xoxo siri', 'murmur[body]')

    murmur['murmur']['body'].should =~ /happy to mingle/
  end
  
  it "should accept a command for post" do
    mingle = MingleParty.new(host, username, password, project)
    post_with_command = mingle.post('happy to mingle xoxo siri', 'card[new]')

    post_with_command.should be_true
  end

end
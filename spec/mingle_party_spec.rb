require 'spec_helper'

describe MingleParty do
  
  it "find card" do
    mingle = MingleParty.new
    card = mingle.fetch_card(13)

    card['card']['properties'].first['value'].should =~ /Just started/
    card['card']['name'].should =~ /card 13/
    card['card']['description'].should == "I love Siri and So should you."
  end

  it "change card status to done" do
    mingle = MingleParty.new
    card = mingle.change_card_status(11, "done")

    card['card']['name'].should =~ /Implement the SiriMingle Feature/
    card['card']['properties'].first['value'].should =~ /done/
  end

  it "murmur about its happiness" do
    mingle = MingleParty.new
    murmur = mingle.murmur('happy to mingle xoxo siri', 'murmur[body]')

    murmur['murmur']['body'].should =~ /happy to mingle/
  end
  
  it "create a card" do
    mingle = MingleParty.new
    card = mingle.create_card('black jack', 'bug')
    
    card.should_not be_nil
  end
end

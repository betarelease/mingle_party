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
    response = mingle.create_card('card status change test', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.fetch_card(card_number)

    card = mingle.change_card_status(card['card']['number'], "done")

    card['card']['name'].should =~ /card status change test/
    card['card']['properties'].first['value'].should =~ /done/
  end

  it "murmur about its happiness" do
    mingle = MingleParty.new
    murmur = mingle.murmur('happy to mingle xoxo siri', 'murmur[body]')

    murmur['murmur']['body'].should =~ /happy to mingle/
  end
  
  it "create a card" do
    mingle = MingleParty.new
    response = mingle.create_card('black jack', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.fetch_card(card_number)
    
    card.should_not be_nil    
    card['card']['name'].should =~ /black jack/
  end
end

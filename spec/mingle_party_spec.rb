require 'spec_helper'

describe MingleParty do
  let(:mingle) {MingleParty.new}

  it "find card" do
    response = mingle.create_card('card status change test', 'card')

    card = mingle.fetch_cards

    card.should include_json('Just started')
    card['card']['properties'].first['value'].should =~ /Just started/
    card['card']['name'].should =~ /card 13/
    card['card']['description'].should == "I love Siri and So should you."
  end

  it "change card status to done" do
    response = mingle.create_card('card status change test', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.fetch_card(card_number)

    card = mingle.change_card_status(card['card']['number'], "done")

    card['card']['name'].should =~ /card status change test/
    card['card']['properties'].first['value'].should =~ /done/
  end

  it "murmur about its happiness" do
    murmur = mingle.murmur('happy to mingle xoxo siri', 'murmur[body]')

    murmur['murmur']['body'].should =~ /happy to mingle/
  end

  it "create a card" do
    response = mingle.create_card('black jack', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.fetch_card(card_number)

    card.should_not be_nil
    card['card']['name'].should =~ /black jack/
  end

  it "create an admin user" do
    user = { :name => "jsmith",
             :login => "johnsmithcom",
             :email => "john@smith.com",
             :password => "abcd1234",
             :password_confirmation => "abcd1234",
             :admin => "false" }
    response = mingle.create_user(user)
    response.should be_success
  end

  it "create a system user" do
    user = { :name => "jsystem",
             :login => "john@system.com",
             :email => "john@system.com",
             :password => "abcd1234",
             :password_confirmation => "abcd1234",
             :admin => "false",
             :system => "true" }
    response = mingle.create_user(user)
    response.should be_success
  end

  it "fetch users" do
    response = mingle.fetch_users
    users = response['projects_members']
    users.should_not be_empty
  end

  it "fetches all the cards" do

  end
end

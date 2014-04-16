require 'spec_helper'

describe MingleParty do
  let(:mingle) {MingleParty.new}

  it "find card" do
    response = mingle.create_card('find this card', 'card')
    cards = mingle.cards
    cards.first["name"].should == "find this card"
  end

  it "change card status to done" do
    response = mingle.create_card('card status change test', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.card(card_number)

    card = mingle.change_card_status(card['card']['number'], "done")

    card['card']['name'].should =~ /card status change test/
    card['card']['properties'].first['value'].should =~ /done/
  end

  it "murmurs a message" do
    message = "test murmur spec"
    mingle.murmur(message)
    murmurs = mingle.murmurs
    murmur = murmurs.detect do |m|
      m["body"] =~ /test murmur spec/
    end
    murmur["body"].should =~ /test murmur spec/
  end

  it "shows all murmurs" do
    murmurs = mingle.murmurs
    murmurs.should_not be_empty
  end

  it "create a card" do
    response = mingle.create_card('black jack', 'card')
    card_number = response['location'].split("/").last.split(".").first
    card = mingle.card(card_number)

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
    users = mingle.users
    users.should_not be_empty
  end

  it "fetches a list of attachments" do
    card_number = 132
    response = mingle.attachments(card_number)
    attachments = response['attachments']

    attachments.should_not be_empty
    attachments.size.should == 3
  end

  it "fetches the first attachment from url" do
    card_number = 132
    response = mingle.attachments(card_number)
    attachments = response['attachments']

    response = mingle.attachment(attachments.last["url"])
    image_file = File.open("attachment_received.jpg", "w+")
    image_file << response
    image_file.close

    File.stat("attachment_received.jpg").should_not be_zero
  end
end

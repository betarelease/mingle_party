require 'spec_helper'

describe HttpApi do

  describe "projects" do
    it "lists all projects" do
      projects = Projects.new
      project_names = projects.map { |p|  p['name']}
      project_names.include? "test project"
    end

    it "lists all events for a project" do
      project_identifier = "test_project"
      events = Projects.new.events_for(project_identifier)
      puts events.inspect
    end
  end

  describe "cards" do
    it "create a card" do
      cards = Cards.new
      response = cards.create('black jack', 'card')
      card_number = response['location'].split("/").last.split(".").first
      card = cards.find(card_number)

      card.should_not be_nil
      card['card']['name'].should =~ /black jack/
    end

    it "find card" do
      cards = Cards.new
      response = cards.create('find this card', 'card')

      cards.all.first["name"].should == "find this card"
    end

    it "change card status to done" do
      cards = Cards.new
      response = cards.create('card status change test', 'card')
      card_number = response['location'].split("/").last.split(".").first
      card = cards.find(card_number)

      card = cards.change_status(card['card']['number'], "done")

      card['card']['name'].should =~ /card status change test/
      card['card']['properties'].first['value'].should =~ /done/
    end
  end

  describe "murmurs" do
    it "murmurs a message" do
      murmurs = Murmurs.new
      message = "test murmur spec"
      murmurs.mutter(message)

      murmur = murmurs.all.detect do |m|
        m["body"] =~ /test murmur spec/
      end

      murmur["body"].should =~ /test murmur spec/
    end

    it "shows all murmurs" do
      murmurs = Murmurs.new
      murmurs.all.should_not be_empty
    end
  end

  describe "users" do
    it "create an admin user" do
      user = { :name => "jsmith",
               :login => "johnsmithcom",
               :email => "john@smith.com",
               :password => "abcd1234",
               :password_confirmation => "abcd1234",
               :admin => "false" }
      users = Users.new
      response = users.create(user)
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
      users = Users.new
      response = users.create(user)
      response.should be_success
    end

    it "fetch users" do
      users = Users.new
      users.all.should_not be_empty
    end
  end

  describe "attachments" do
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

end

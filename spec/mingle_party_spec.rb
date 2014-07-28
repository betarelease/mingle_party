require 'spec_helper'

describe HttpApi do

  describe "projects" do
    it "lists all projects" do
      projects = Projects.new
      project_names = projects.map { |p|  p['name']}
      expect(project_names).to include("test project")
    end

    it "lists all events for a project" do
      project_identifier = "test_project"
      events = Projects.new.events_for(project_identifier)
      expect(events).to_not be_empty
    end
  end

  describe "cards" do
    it "create a card" do
      cards = Cards.new
      response = cards.create('black jack', 'card')
      card_number = response['location'].split("/").last.split(".").first
      card = cards.find(card_number)

      card.should_not be_nil
      expect(card['card']['name']).to match(/black jack/)
    end

    it "find card" do
      cards = Cards.new
      response = cards.create('find this card', 'card')

      expect(cards.all.first["name"]).to eq("find this card")
    end

    it "change card status to done" do
      cards = Cards.new
      response = cards.create('card status change test', 'card')
      card_number = response['location'].split("/").last.split(".").first
      card = cards.find(card_number)

      card = cards.change_status(card['card']['number'], "done")

      expect(card['card']['name']).to match(/card status change test/)
      expect(card['card']['properties'].first['value']).to match(/done/)
    end
  end

  describe "murmurs" do
    it "murmurs a message" do
      murmurs = Murmurs.new
      message = "test murmur spec"
      murmurs.mutter(message)

      murmur = murmurs.all.detect do |m|
        expect(m["body"]).to match(/test murmur spec/)
      end

      expect(murmur["body"]).to match(/test murmur spec/)
    end

    it "shows all murmurs" do
      murmurs = Murmurs.new
      expect(murmurs.all).to_not be_empty
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
      expect(response).to be_success
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
      expect(response).to be_success
    end

    it "fetch users" do
      users = Users.new
      expect(users.all).to_not be_empty
    end
  end

  describe "attachments" do
    it "attaches a file to a card" do
      card_number = 727
      response = Attachments.new.attach(card_number, "README.md")
      expect(response['location']).to match(/attachments/)
    end
  end

end

# spec/app_spec.rb
require_relative '../../src/controller/event_controller.rb'
require_relative '../spec_helper.rb'
require 'pry'

describe EventController do
  let(:person) {
    {
      first_name: 'John',
      last_name: 'Smith',
      email: 'john.smith@example.com',
      face_id: SecureRandom.uuid
    }
  }
  let(:event) {
    {
      face_id: person[:face_id],
      timestamp: Time.now,
      location: 'A'
    }
  }
  context 'POST' do
    before(:each) do
      Person.insert(
        person
      )
    end

    subject { post '/event', event }

    it "should create an event object" do
      subject
      expect(last_response).to be_ok
    end
  end
end
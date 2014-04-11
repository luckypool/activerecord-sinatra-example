require "spec_helper"
require "rack/test"
require "json"

describe "app.rb" do
  include Rack::Test::Methods

  def app
    TutorialApp
  end

  let(:expected) { {name: "Great King", birthday: Date.new(1999,7,1).to_s} }
  let!(:posted) {
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
      JSON.parse(last_response.body)
  }

  context "when GET /users" do
    before do
      get "/users"
    end
    it "returns user json collection" do
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to include(posted)
    end
  end

  context "when GET /users/:id" do
    before do
      get "/users/#{posted['id']}"
    end
    it { expect(last_response.status).to eq 200 }
    describe "Response Body" do
      it{ expect(JSON.parse(last_response.body)).to include(posted) }
    end
  end

  context "when POST /users" do
    before do
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
    end
    it { expect(last_response.status).to eq 201 }
    describe "Response Body" do
      it {
        expect(JSON.parse(last_response.body)).to include("id", "name", "birthday", "created_at", "updated_at")
      }
    end
  end

  context "when PUT /users/:id" do
    before do
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
      initial_data = JSON.parse(last_response.body)
      put "/users/#{initial_data['id']}", initial_data.to_json, "CONTENT_TYPE" => "application/json"
    end
    it { expect(last_response.status).to eq 200 }
    describe "Response Body" do

      it {
        expect(JSON.parse(last_response.body)).to include("id", "name", "birthday", "created_at", "updated_at")
      }
    end
  end

end


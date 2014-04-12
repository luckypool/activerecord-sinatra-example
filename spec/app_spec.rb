require "spec_helper"
require "rack/test"
require "json"

shared_examples_for "user object(s)" do 
  describe "Header" do
    it { expect(response.header).to include("Content-Type"=>"application/json") }
  end

  describe "Body" do
    it { expect(JSON.parse(response.body)).to include(expected_body) }
  end
end

shared_examples_for "200 ok" do
  describe "Status" do
    it { expect(response.status).to eq 200 }
  end
  it_behaves_like "user object(s)"
end

shared_examples_for "201 created" do
  describe "Status" do
    it { expect(response.status).to eq 201 }
  end
  it_behaves_like "user object(s)"
end

shared_examples_for "204 no content" do
  describe "Status" do
    it { expect(response.status).to eq 204 }
  end
end

describe "app.rb" do
  include Rack::Test::Methods

  def app
    TutorialApp
  end

  let(:expected) { {name: "Great King", birthday: "1997-01-01"} }

  context "when GET" do
    let!(:expected_body) {
        post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
        JSON.parse(last_response.body)
    }
    after :all do
      delete "/users/#{expected_body['id']}"
    end

    context "with /users" do
      let!(:response) { get "/users" }
      it_behaves_like "200 ok"
    end

    context "with /users/:id" do
      let!(:response) { get "/users/#{expected_body['id']}" }
      it_behaves_like "200 ok"
    end
  end

  context "when POST /users" do
    let!(:response) {
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json" 
    }
    let(:id) { JSON.parse(response.body)['id'] }
    let!(:expected_body) {
      get "/users/#{id}"
      JSON.parse(last_response.body)
    }
    after :all do
      delete "/users#{id}"
    end

    it_behaves_like "201 created"
  end

  context "when PUT /users/:id" do
    let!(:response) {
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
      initial_data = JSON.parse(last_response.body)
      initial_data['name'] = "King?"
      put "/users/#{initial_data['id']}", initial_data.to_json, "CONTENT_TYPE" => "application/json"
    }
    let(:id) { JSON.parse(response.body)['id'] }
    let!(:expected_body) {
      get "/users/#{id}"
      JSON.parse(last_response.body)
    }
    after :all do
      delete "/users#{id}"
    end

    it_behaves_like "200 ok"
  end

  context "when DELETE /users/:id" do
    let!(:posted) {
      post "/users", expected.to_json, "CONTENT_TYPE" => "application/json"
      JSON.parse(last_response.body)
    }
    let!(:response) {
      delete "/users/#{posted['id']}"
    }
    let(:id) { JSON.parse(response.body)['id'] }
    it_behaves_like "204 no content"
  end
end


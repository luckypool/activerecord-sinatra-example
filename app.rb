require "sinatra"
require "sinatra/json"
require "sinatra/activerecord"
require "oj"
require_relative "models/user"

class TutorialApp < Sinatra::Base
  set :database_file, "config/database.yml"

  before do
    ActiveRecord::Base.establish_connection(ENV["RACK_ENV"].to_sym)
  end

  post "/users" do
    data = Oj.load(request.body.read)
    user = User.create!(data)
    response.status = 201
    json user
  end

  get "/users/:id" do
    user = User.where("id" => params[:id]).first
    json user
  end

  get "/users" do
    users = User.all
    json users
  end

  put "/users/:id" do
    user = User.where("id" => params[:id]).first
    data = Oj.load(request.body.read)
    user.name = data["name"]
    user.birthday = data["birthday"]
    user.save!
    json user
  end

  delete "/users/:id" do
    user = User.where("id" => params[:id]).first
    user.destroy
    response.status = 204
    nil
  end

  after do
    ActiveRecord::Base.connection.close
  end
end


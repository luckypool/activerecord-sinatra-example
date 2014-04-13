require "sinatra/base"
require "sinatra/json"
require "sinatra/activerecord"
require "oj"

require_relative "models/user"

class TutorialApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"

  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  post "/users" do
    data = Oj.load(request.body.read)
    begin
      user = User.create!(data)
      response.status = 201
      json user
    rescue ActiveRecord::RecordInvalid
      response.status = 400
      nil
    end
  end

  get "/users/:id" do
    user = User.where("id" => params[:id]).first
    unless user
      response.status = 404
      nil
    else
      json user
    end
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
    begin
      user.save!
      json user
    rescue ActiveRecord::RecordInvalid
      response.status = 400
      nil
    end
  end

  delete "/users/:id" do
    user = User.where("id" => params[:id]).first
    user.destroy
    response.status = 204
    nil
  end
end


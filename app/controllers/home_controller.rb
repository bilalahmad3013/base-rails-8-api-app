class HomeController < ApplicationController
  def index
    render json: "Hello from API based rails app"
  end
end

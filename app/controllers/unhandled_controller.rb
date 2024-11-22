class UnhandledController < ApplicationController
  def index
    render json: "This routes does not exists"
  end
end

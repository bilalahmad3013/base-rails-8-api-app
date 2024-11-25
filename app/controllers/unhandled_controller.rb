class UnhandledController < ApplicationController
  def index
    render_failure(message: "This routes does not exists")
  end
end

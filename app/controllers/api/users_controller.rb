class Api::UsersController < ApplicationController

  def index
    users = User.all
    render json: { data: users }
  end
end

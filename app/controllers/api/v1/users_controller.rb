class Api::V1::UsersController < ApplicationController
  def create
    render :json => SignUp.new(params).create
  end
end

class Api::V1::SessionsController < ApplicationController
  def create
    render :json => Session.new(params).create
  end

  def destroy
    render :json => Session.new(params).destroy
  end

  def check_auth_token
    render :json => Session.new(params).check_auth_token_existance
  end
end
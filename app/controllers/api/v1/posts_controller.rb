class Api::V1::PostsController < ApplicationController
  before_filter :authenticate, only: [:create, :delete, :update]
  def create
    post = Post.new({
      title: params[:title], 
      content: params[:content],
      user_id: current_user.id
    })

    if post.save
      render :json => {
        errorCode: 0,
        username: current_user.username
      }
    else
      render :json => {
        errorCode: -444
      }
    end  

    
  end

  def index

  end

  def delete

  end

  def update

  end

  def show
    
  end
end

class Api::V1::CommentsController < ApplicationController
  before_filter :authenticate, only: [:create]

  def create
    comment = Comment.new({
      content: params[:content],
      post_id: params[:post_id].to_i,
      username: current_user.username
    })

    if comment.save
      render :json => {
        errorCode: 0
      }
    else
      render :json => {
        errorCode: -444
      }
    end      
  end
end

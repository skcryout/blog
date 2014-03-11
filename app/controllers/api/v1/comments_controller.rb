class Api::V1::CommentsController < ApplicationController
  before_filter :authenticate, only: [:create]

  def create
    comment = Comment.new({
      content: params[:content],
      post_id: params[:post_id].to_i,
      user_id: current_user.id
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

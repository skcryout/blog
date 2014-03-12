class Api::V1::PostsController < ApplicationController
  before_filter :authenticate, only: [:create, :destroy, :update]
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

  def personal
    user = User.includes(:posts).includes(:comments).find_by(username: params[:username])
    if user
      render :json => user.to_json(:include => { 
          :posts => {
          :include => :comments
        }
      }, :only => :id)
    else
      render :json => {
        errorCode: -4444
      }
    end
  end

  def index
    user = User.includes(:posts).includes(:comments).all
    if user
      render :json => user.to_json(:include => { 
          :posts => {
          :include => :comments
        }
      }, :only => :id)
    else
      render :json => {
        errorCode: -4444
      }
    end
  end

  def destroy
    if current_user.posts.length > 0 && current_user.posts.find(params[:post_id].to_i)
      if current_user.posts.find(params[:post_id].to_i).destroy
        render :json => {
          errorCode: 0 #삭제가 잘 됨
        }  
      else
        render :json => {
          errorCode: -44 #알수 없는 에러
        }  
      end
    else
      render :json => {
        errorCode: 10 #해당 블로그가 현재 접속중인 회원의 소유가 아닌 경우
      }
    end
    
  end

  def update

  end

  def show
    
  end
end

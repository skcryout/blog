class Api::V1::TitleController < ApplicationController
  def number_of_posts_and_users
    render :json => {
      number_of_users: User.all.length,
      number_of_posts: Post.all.length
    }
  end
end

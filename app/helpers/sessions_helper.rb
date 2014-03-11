module SessionsHelper
  def authenticate
    param = create_params_for_authentication params
    user = User.find_by(authentication_token: param[:auth_token])

    if user
      current_user = user
    else
      render :json => {
        errorCode: -4444
      }
    end
  end

  def current_user
    @current_user ||= User.find_by(authentication_token: create_params_for_authentication(params)[:auth_token])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  private
    def create_params_for_authentication(params)
      params = ActionController::Parameters.new({
        user: params
      })
      params.require(:user).permit(:auth_token)
    end
end

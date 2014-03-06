require 'bcrypt'
class Session
  def initialize(params)
    @params = params
  end

  def create
    params = create_params
    exception = exception_handler_for_create params
    return exception if exception


    user = User.find_by(username: params[:username])

    if BCrypt::Password.new(user[:encrypted_password]) == params[:password]
      auth_token = create_authentication_token
      user.update_attributes(authentication_token: auth_token)
      return {
        statusCode: 100,
        auth_token: auth_token
      }
    else
      return {
        statusCode: -100
      }
    end
  end

  def destroy
    params = ActionController::Parameters.new({
        user: @params
    })
    params = params.require(:user).permit(:auth_token)

    exception = exception_handler_for_destroy params
    return exception if exception

    user = User.find_by(authentication_token: params[:auth_token])
    if user
      user.update_attributes(authentication_token: nil)
      return {
        statusCode: 100
      }
    else
      return {
        statusCode: -100
      }
    end

  end

  def check_username_existance(username)
    user = User.find_by(username: username)

    if user
      true
    else
      false
    end
  end

  def exception_handler_for_create(params)
    return {statusCode: -101} if params[:username].length == 0
    return {statusCode: -102} if params[:password].length == 0
    return {statusCode: -103} if !check_username_existance(params[:username])
  end

  def exception_handler_for_destroy(params)
    return {statusCode: -101} if params[:auth_token].length == 0
  end

  private
    def create_authentication_token
      SecureRandom.urlsafe_base64(25, false)
    end

    def create_params
      params = ActionController::Parameters.new({
        user: @params
      })
      params.require(:user).permit(:username, :password)
    end
end
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
    return {errorCode: 305} if user.nil? 

    if BCrypt::Password.new(user[:encrypted_password]) == params[:password]
      auth_token = create_authentication_token
      user.update_attributes(authentication_token: auth_token)
      
      return {
        errorCode: 0,
        auth_token: auth_token
      }
    else
      return {
        errorCode: 400
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
        errorCode: 0
      }
    else
      return {
        errorCode: 400
      }
    end

  end

  def check_username_existance(username)
    if User.find_by(username: username)
      true
    else
      false
    end
  end

  def check_auth_token_existance
    return {errorCode: 300} if (@params[:auth_token].nil?)||(@params[:auth_token].length == 0)
    if User.find_by(authentication_token: @params[:auth_token])
      return {
        errorCode: 0
      }
    else
      return {
        errorCode: 100
      }
    end
  end

  def exception_handler_for_create(params)
    return {errorCode: 100} if params[:username].nil? || params[:username].length == 0
    return {errorCode: 101} if params[:password].nil? || params[:password].length == 0
  end

  def exception_handler_for_destroy(params)
    return {errorCode: 300} if (params[:auth_token].nil?)||(params[:auth_token].length == 0)
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
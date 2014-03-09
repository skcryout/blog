require 'bcrypt'
class SignUp
  def initialize(params)
    @params = params
  end

  def create
    params = create_params
    exception = exception_handler params
    return exception if exception

    @user = User.new(
      username: params[:username], 
      encrypted_password: BCrypt::Password.create(params[:password]), 
      authentication_token: create_authentication_token
    )

    if @user.save
      return { 
        errorCode: 0,
        auth_token: @user.authentication_token
      }
    else
      return {
        errorCode: 400
      }
    end
  end

  def exception_handler(params)
    return {errorCode: 100} if params[:username].nil? || params[:username].length == 0
    return {errorCode: 101} if params[:password].nil? || params[:password].length == 0
    return {errorCode: 102} if params[:password].length < 6 || params[:password_confirmation].length < 6
    return {errorCode: 103} if params[:password] != params[:password_confirmation]    
    return {errorCode: 120} if check_username_existance(params[:username])

  end

  def check_username_existance(username)
    if User.find_by(username: username)
      true
    else
      false
    end
  end

  private
    def create_authentication_token
      SecureRandom.urlsafe_base64(25, false)
    end

    def create_params
      params = ActionController::Parameters.new({
        user: @params
      })
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
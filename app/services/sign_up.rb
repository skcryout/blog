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
        statusCode: 100,
        auth_token: @user.authentication_token
      }
    else
      return {
        statusCode: -200
      }
    end
  end

  def exception_handler(params)
    return {statusCode: -100} if params[:username].length == 0
    return {statusCode: -101} if params[:password].length == 0
    return {statusCode: -102} if params[:password_confirmation].length == 0
    return {statusCode: -103} if check_username_existance(params[:username])
    return {statusCode: -104} if params[:password] != params[:password_confirmation]
  end

  def check_username_existance(username)
    user = User.find_by(username: username)

    if user
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
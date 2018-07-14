# frozen_string_literal: true

# :nodoc:
class UsersController < ApiController
  before_action :authenticate_user
  before_action :set_user, only: %i[show]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    email, password = user_params.values_at(:email, :password)
    curr_email = current_user.email

    @user = User.find_by(email: curr_email).try(:authenticate, password)
    exception = %i[password_digest created_at updated_at]

    return head :forbidden if @user == false
    return head :forbidden unless @user.id == current_user.id

    if @user.update(email: email)
      render json: @user.as_json(except: exception), status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def current
    # results = {
    #   "email": {
    #     "value": current_user.email
    #   },
    #   "id": {
    #     "value": current_user.id
    #   }
    # }
    exception = %i[password_digest created_at updated_at]
    render json: current_user.as_json(except: exception)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # params.require(:user).permit(:email, :password_digest, :admin, :role)
    params.require(:user).permit(:email, :password)
  end
end

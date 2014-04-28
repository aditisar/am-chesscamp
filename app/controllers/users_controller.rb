class UsersController < ApplicationController

  
  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to home_path
    else
      render action: 'new'
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :role, :active, :password, :password_confirmation, :band_id)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  def edit
  end

end


    # t.string  "username"
    # t.string  "password_digest"
    # t.integer "instructor_id"
    # t.string  "role"
    # t.boolean "active"
class UsersController < ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
      flash[:error] = "Must be logged in or registered to access dashboard!"
    end
  end 

  def create 
    user = User.create(user_params)
    # if user.save
    session[:user_id] = user.id
    redirect_to dashboard_path
    # else  
    #   flash[:error] = user.errors.full_messages.to_sentence
    #   redirect_to register_path
    # end 
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout_user
    session[:user_id] = nil
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 
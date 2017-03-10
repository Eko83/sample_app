class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])

  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) #not the final implementation!
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Om Telolet!"
      redirect_to @user # handle a succesful save
  	else
  		render 'new'
  	end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end


end

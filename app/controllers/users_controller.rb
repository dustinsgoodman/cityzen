class UsersController < ApplicationController
  skip_before_filter :store_location, :except => [:show]
  before_filter :keep_location
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :update, :change_password]
  before_filter :load_user, :only => [:show, :edit, :update, :destroy, :change_password]

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def edit

  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def load_user
    if logged_in?
      @user = current_user
    else
      flash[:error] = "You must be logged in."
      redirect_to root_url
    end
  end
  
end
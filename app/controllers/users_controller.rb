class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :accounts]
  before_action :get_accounts, only: [:accounts]
  before_action :get_organizations

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def home

  end

  def accounts

  end

  def search
    if params['organization_id'] == 'All Orgs'
      @users = User.all
      render 'index'
    else
      @users = User.where(organization_id: params['organization_id'])
      render 'index'
    end
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.initialize_accounts
        if current_user.id != @user.id
          log_in @user
          flash[:success] = "Welcome to the #{@user.organization.name}!"
          format.html { redirect_to @user }
        else
          render '/users'
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user.assign_attributes(user_params)
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def get_accounts
      @user_accounts = @user.get_accounts
    end

    def get_organizations
      @organizations_for_select = Organization.all.collect{|x| [x.name, x.id]}
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :login, :password, :admin, :organization_id)
    end
end

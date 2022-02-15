class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :is_permitted, only: %i[ edit update destroy ]

  # GET /users or /users.json
  #Only members to hide guests
  def index
    @users = User.members
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Checks to see if current session user has perms to do actions
    def is_permitted
      @permitted ||= sessioned_user.isAdmin || (User.find(params[:id]).email == current_admin.email)
      unless @permitted
        respond_to do |format|
          format.html { redirect_to users_url, notice: "You do not have the perms to do this." }
          format.json { render :show, status: :ok, location: @user }
        end
      end
    end
    #Gets current session user by user table
    def sessioned_user
      @sessioned_user = User.find_by(email: current_admin.email)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :role, :bio, :isAdmin)
    end
end

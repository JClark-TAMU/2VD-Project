class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :is_permitted, only: %i[edit update destroy]

  # GET /users or /users.json
  # Only members to hide guests
  def index
    @users = User.members
  end

  def officers
    @users = User.officers
  end

  # GET /users/1 or /users/1.json
  def show
    @images = user_profile_images
  end

  # GET /users/new
  def new
    @user = User.new
    @roles = get_roles
  end

  # GET /users/1/edit
  def edit
    @roles = get_roles
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      params = user_params
      user_admin = params[:isAdmin]
      @user.isAdmin = true if user_admin
      @user.isAdmin = false unless user_admin
      if @user.update(user_params)
        unless Portfolio.exists?(user_id: @user.id)
          @portfolio = @user.create_portfolio(user_id: @user.id, title: 'untitled')
          @user.portfolioID = @portfolio.id
        end
        format.html { redirect_to(user_url(@user), notice: 'User was successfully updated.') }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @images = Image.ownedby(@user.id)
    @images do |image|
      image.destroy
    end
    @portfolio = Portfolio.find(@user.portfolioID)
    @user.portfolioID = nil
    @portfolio.destroy
    @email = @user.email
    @user.destroy

    if @email != sessioned_user.email
      respond_to do |format|
        format.html { redirect_to(users_url, notice: 'User was successfully destroyed.') }
        format.json { head(:no_content) }
      end
    end
    if @email == sessioned_user.email
      respond_to do |format|
        format.html { redirect_to(destroy_admin_session_path, notice: 'User was successfully destroyed.') }
        format.json { head(:no_content) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :role, :bio, :isAdmin, portfolio_attributes: %i[title id])
  end

  def user_profile_images
    Image.ownedby(@user.id).publicimages
  end

  def get_roles
    if User.find(current_admin.id).isAdmin
      return admin_roles
    end
    return member_roles
  end
end

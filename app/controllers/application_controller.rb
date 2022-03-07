class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  include ActiveStorage::SetCurrent

  # Checks to see if current session user has perms to do actions
  def is_permitted
    @permitted ||= sessioned_user.isAdmin || (User.find(params[:id]).email == current_admin.email)
    unless @permitted
      respond_to do |format|
        format.html { redirect_to(users_url, notice: 'You do not have the perms to do this.') }
        format.json { render(:show, status: :ok, location: @user) }
      end
    end
  end

  # Gets current session user by user table
  def sessioned_user
    @sessioned_user = User.find_by(email: current_admin.email)
  end
end

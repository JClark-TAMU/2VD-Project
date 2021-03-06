class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy unlink unalbum]

  # GET /images or /images.json
  def index
    @images = Image.all
  end

  # GET /images/1 or /images/1.json
  def show; end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit; end

  def unlink
    @image.update(galleries_id: nil)
    respond_to do |format|
      format.html { redirect_to(image_path(@image), notice: 'Image was successfully removed from gallery.') }
      format.json { head(:no_content) }
    end
  end

  def unalbum
    @image.update(albums_id: nil)
    respond_to do |format|
      format.html { redirect_to(image_path(@image), notice: 'Image was successfully removed from album.') }
      format.json { head(:no_content) }
    end
  end

  # POST /images or /images.json
  def create
    @user = User.find_by(email: current_admin.email)
    @image = Image.new(image_params)
    # Allows untitled images
    @image.title = 'Untitled' if @image.title == ''
    @image.users_id = @user.id
    @image.portfolios_id = Portfolio.find_by(user_id: @image.users_id).id

    respond_to do |format|
      if @image.save
        format.html { redirect_to(image_url(@image), notice: 'Image was successfully created.') }
        format.json { render(:show, status: :created, location: @image) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @image.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to(image_url(@image), notice: 'Image was successfully updated.') }
        format.json { render(:show, status: :ok, location: @image) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @image.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @user = @image.users_id
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(user_path(@user), notice: 'Image was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:title, :caption, :showOnPortfolio, :imageLink, :users_id)
  end
end

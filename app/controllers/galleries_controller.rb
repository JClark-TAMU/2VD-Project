class GalleriesController < ApplicationController
  before_action :set_gallery, only: %i[ show edit update destroy gallery submit add]

  # GET /galleries or /galleries.json
  def index
    @galleries = Gallery.all.order("created_at DESC")
  end

  # GET /galleries/1 or /galleries/1.json
  def show
    @images = Image.ingallery(@gallery.id)
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # GET /galleries/1/submit
  def submit
    @user_images = Image.ownedby(User.find_by(email: current_admin.email))
  end

  # PATCH /galleries/1/submit
  def add
    Image.find(params[:image]).update(galleries_id: @gallery.id)

    respond_to do |format|
      format.html { redirect_to galleries_url, notice: "Image was successfully added." }
      format.json { head :no_content }
    end
  end

  # POST /galleries or /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to gallery_url(@gallery), notice: "Gallery was successfully created." }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1 or /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to gallery_url(@gallery), notice: "Gallery was successfully updated." }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1 or /galleries/1.json
  def destroy
    # remove all links from image to gallery
    @images = Image.ingallery(@gallery)
    @images.each do |image|
      image.update(galleries_id: nil)
    end
    # destory gallery
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to galleries_url, notice: "Gallery was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gallery_params
      params.require(:gallery).permit(:prompt)
    end
end

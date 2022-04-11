class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy add link]

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1/user or /albums/1/user.json
  def user
    @user = User.find(id: params[:id])
    @albums = Album.ownedby(@user)
  end

  # GET /albums/1 or /albums/1.json
  def show
    @images = Image.inalbum(@album.id)
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # GET /albums/1/add
  def add
    @user_images = Image.ownedby(User.find_by(email: current_admin.email))
  end

  # PATCH /albums/1/link
  def link
    Image.find(params[:image]).update(albums_id: @album.id)

    respond_to do |format|
      format.html { redirect_to user_album_url(@album.user_id), notice: params[:image] }
      format.json { head :no_content }
    end
  end

  # POST /albums or /albums.json
  def create
    @user = User.find_by(email: current_admin.email)
    @album = Album.new(album_params)
    @album.user_id = @user.id
    @album.portfolio_id = Portfolio.find_by(user_id: @album.user_id).id

    respond_to do |format|
      if @album.save
        format.html { redirect_to user_album_url(@album.user_id), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to user_album_url(@album.user_id), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    # remove all links from image to album
    @images = Image.ingallery(@album)
    @images.each do |image|
      image.update(albums_id: nil)
    end
    # destory album
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :caption)
    end
end

class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.page(params[:page]).per(25)
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    # to change. still working on the pagination/load more
    @gallery_attachments = @gallery.gallery_attachments.all#.page(params[:page]).per(2)
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
    @gallery_attachment = @gallery.gallery_attachments.build
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)    
    if @gallery.save
      redirect_to new_gallery_gallery_attachment_path(@gallery)
    else
      render json: @gallery.errors, status: :unprocessable_entity 
    end    
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:title)
    end
end

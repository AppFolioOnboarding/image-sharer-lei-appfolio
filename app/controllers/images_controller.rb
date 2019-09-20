class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    search_tag = search_tag_params[:search_tag]
    @index_view_model = ImagesIndexView.new(search_tag: search_tag)
    images = search_tag.blank? ? Image.all : Image.tagged_with(search_tag)
    @reversed_images = images.reverse
  end

  def show
    @image = Image.find_by_id(params[:id])
    # This is different from `@image = Image.find(params[:id])`
    # It assigns nil to @image when the id is not found
    # But `Image.find(params[:id])` throws an exception

    flash[:notice] = 'Image url is not found.' if @image.nil?
    redirect_to images_path if @image.nil?
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:notice] = 'Image url was successfully submitted.'
      redirect_to @image
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy!
    flash[:notice] = 'Image url was successfully deleted.'
    redirect_to images_path
  end

  private

  # Only allow a trusted parameter "white list" through.
  def image_params
    params.require(:image).permit(:web_url, :mytag_list)
  end

  def search_tag_params
    params.permit(:search_tag)
  end
end

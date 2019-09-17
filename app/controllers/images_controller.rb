class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image, notice: 'Image url was successfully submitted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def image_params
    params.require(:image).permit(:web_url)
  end
end

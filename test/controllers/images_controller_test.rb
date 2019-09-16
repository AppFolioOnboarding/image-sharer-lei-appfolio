require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path

    assert_response :ok
    assert_select 'h1', 'New Image URL'
    assert_select '.new_image'
    assert_select '.simple_form'
    assert_select '#new_image'
  end

  def test_show
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')

    get image_path(@image.id)

    assert_response :ok
    assert_select 'strong', 'url:'
    assert_select 'img'
    assert_select 'a', 'Back to Home'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { web_url: 'https://imgur.com/gallery/Lz2m84C' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image url was successfully submitted.', flash[:notice]
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_params = { web_url: 'Hello world' }
      post images_path, params: { image: image_params }
    end

    assert_response :unprocessable_entity
    assert_select 'span', 'is an invalid URL'
  end
end

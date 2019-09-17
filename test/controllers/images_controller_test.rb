require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path

    assert_response :ok
    assert_select 'h1', 'New Image URL'
    assert_select '.new_image'
    assert_select '.simple_form'

    assert_select '.images_form_1', 2

    assert_select '#new_image', 1
    assert_select '#new_image' do
      assert_select '.image_web_url'
      assert_select '.image_mytag_list'
      assert_select '.btn'
    end

    assert_select 'a', 'All Images'
    assert_select 'a', 'Home'
  end

  def test_index
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select 'a', 'Submit Image'
    assert_select 'a', 'Home'
  end

  def test_index_image_order
    url1 = 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg'
    url2 = 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg'
    url3 = 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg'
    Image.create!(web_url: url1)
    Image.create!(web_url: url2)
    Image.create!(web_url: url3)

    get images_path
    assert_response :ok

    assert_select 'ul', 1
    assert_select 'li', 3

    assert_select 'li:nth-child(1)' do
      assert_select format('img[src="%<url>s"]', url: url3)
    end

    assert_select 'li:nth-child(2)' do
      assert_select format('img[src="%<url>s"]', url: url2)
    end

    assert_select 'li:nth-child(3)' do
      assert_select format('img[src="%<url>s"]', url: url1)
    end
  end

  def test_show
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')

    get image_path(@image.id)

    assert_response :ok
    assert_select 'strong', 'url:'
    assert_select 'img'
    assert_select 'a', 'All Images'
    assert_select 'a', 'Home'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { web_url: 'https://imgur.com/gallery/Lz2m84C' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image url was successfully submitted.', flash[:notice]

    assert_equal [], Image.last.mytag_list
  end

  def test_create__tags
    assert_difference('Image.count', 1) do
      image_params = { web_url: 'https://imgur.com/gallery/Lz2m84C', mytag_list: 'cute, cat' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image url was successfully submitted.', flash[:notice]

    assert_equal %w[cute cat], Image.last.mytag_list
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

require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
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

  def test_index__tags
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg',
                           mytag_list: 'cute, cat')
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select '.index_have_no_tag', false
    assert_select 'li.index_my_tag', 'cute'
    assert_select 'li.index_my_tag', 'cat'

    assert_select 'a[href=\/images\?search_tag\=cute]', count: 1
    assert_select 'a[href=\/images\?search_tag\=cat]', count: 1

    assert_select 'a', 'Submit Image'
    assert_select 'a', 'Home'

    assert_select 'a', text: 'Delete', count: 1
  end

  def test_index__no_tag
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select '.index_have_no_tag'
    assert_select 'strong', '(This image does not have tags.)'

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

    assert_select 'img' do |element|
      assert_equal url3, element[0][:src]
      assert_equal url2, element[1][:src]
      assert_equal url1, element[2][:src]
    end

    assert_select 'a', text: 'Delete', count: 3
  end

  def test_index__search_tag
    url1 = 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg'
    url2 = 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg'
    url3 = 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg'
    Image.create!(web_url: url1, mytag_list: 'cute, cat')
    Image.create!(web_url: url2, mytag_list: 'cat, dog')
    Image.create!(web_url: url3, mytag_list: 'cute, panda')

    get images_path(search_tag: :cat)
    assert_response :ok

    assert_select 'h1', 'All Images with tag [cat]'

    assert_select 'img', 2
    assert_select 'img' do |element|
      assert_equal url2, element[0][:src]
      assert_equal url1, element[1][:src]
    end

    assert_select 'a', text: 'Delete', count: 2

    assert_select 'li.index_my_tag', text: 'cute', count: 1
    assert_select 'li.index_my_tag', text: 'cat', count: 2
    assert_select 'li.index_my_tag', text: 'dog', count: 1
    assert_select 'li.index_my_tag', text: 'panda', count: 0

    assert_select 'a[href=\/images\?search_tag\=cute]', count: 1
    assert_select 'a[href=\/images\?search_tag\=cat]', count: 2
    assert_select 'a[href=\/images\?search_tag\=dog]', count: 1
    assert_select 'a[href=\/images\?search_tag\=panda]', count: 0

    assert_select 'a', 'All Images'
  end

  def test_index__search_blank
    url1 = 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg'
    url2 = 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg'
    url3 = 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg'
    Image.create!(web_url: url1, mytag_list: 'cute, cat')
    Image.create!(web_url: url2, mytag_list: 'cat, dog')
    Image.create!(web_url: url3, mytag_list: 'cute, panda')

    # case 1
    get images_path(search_tag: '')
    assert_response :ok

    assert_select 'h1', 'All Images'

    assert_select 'img', 3
    assert_select 'img' do |element|
      assert_equal url3, element[0][:src]
      assert_equal url2, element[1][:src]
      assert_equal url1, element[2][:src]
    end

    assert_select 'li.index_my_tag', text: 'cute', count: 2
    assert_select 'li.index_my_tag', text: 'cat', count: 2
    assert_select 'li.index_my_tag', text: 'dog', count: 1
    assert_select 'li.index_my_tag', text: 'panda', count: 1

    assert_select 'a[href=\/images\?search_tag\=cute]', count: 2
    assert_select 'a[href=\/images\?search_tag\=cat]', count: 2
    assert_select 'a[href=\/images\?search_tag\=dog]', count: 1
    assert_select 'a[href=\/images\?search_tag\=panda]', count: 1

    assert_select 'a', text: 'All Images', count: 0
  end

  def test_index__search_nonexistent_tag
    url1 = 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg'
    url2 = 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg'
    url3 = 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg'
    Image.create!(web_url: url1, mytag_list: 'cute, cat')
    Image.create!(web_url: url2, mytag_list: 'cat, dog')
    Image.create!(web_url: url3, mytag_list: 'cute, panda')

    get images_path(search_tag: :earth)
    assert_response :ok

    assert_select 'h1', 'All Images with tag [earth]'

    assert_select 'img', 0
    assert_select 'li.index_my_tag', false

    assert_select 'a', 'All Images'
  end

  def test_show__no_tag
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')
    get image_path(@image.id)

    assert_response :ok
    assert_select 'strong', 'url:'
    assert_select 'img'
    assert_select '#have_no_tag'

    assert_select 'a', 'All Images'
    assert_select 'a', 'Home'

    assert_select '#js-delete'
    assert_select 'a', text: 'Delete', count: 1
  end

  def test_show__no_record
    Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')
    get image_path(125)

    assert_redirected_to images_path
    assert_equal 'Image url is not found.', flash[:notice]
  end

  def test_show__has_tags
    @image = Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg',
                           mytag_list: 'cute, cat')
    get image_path(@image.id)

    assert_response :ok
    assert_select 'strong', 'url:'
    assert_select 'img'
    assert_select '#have_no_tag', false

    assert_select 'li', 2
    assert_select 'li.my_tag', 'cute'
    assert_select 'li.my_tag', 'cat'

    assert_select 'a[href=\/images\?search_tag\=cute]'
    assert_select 'a[href=\/images\?search_tag\=cat]'

    assert_select 'a', 'All Images'
    assert_select 'a', 'Home'

    assert_select '#js-delete'
    assert_select 'a', text: 'Delete', count: 1
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

  def test_index__destroy
    url1 = 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg'
    url2 = 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg'
    url3 = 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg'
    Image.create!(web_url: url1, mytag_list: 'cute, cat')
    @image = Image.create!(web_url: url2, mytag_list: 'cat, dog')
    Image.create!(web_url: url3, mytag_list: 'cute, panda')

    get images_path
    assert_response :ok

    assert_select 'img', 3
    assert_select 'img' do |element|
      assert_equal url3, element[0][:src]
      assert_equal url2, element[1][:src]
      assert_equal url1, element[2][:src]
    end

    assert_select 'a', text: 'Delete', count: 3

    delete image_path(@image.id)

    assert_response :found
    assert_redirected_to images_path

    get images_path
    assert_response :ok

    assert_select 'img', 2
    assert_select 'img' do |element|
      assert_equal url3, element[0][:src]
      assert_equal url1, element[1][:src]
    end

    assert_equal 'Image url was successfully deleted.', flash[:notice]
    assert_select 'a', text: 'Delete', count: 2
  end

  def test_destroy__no_record
    Image.create!(web_url: 'https://i.pinimg.com/originals/3a/42/a6/3a42a627c2da4dc93c1698e86a124bd1.jpg')

    delete image_path(372)
    assert_redirected_to images_path
    assert_equal 'Image url is not found.', flash[:notice]
  end
end

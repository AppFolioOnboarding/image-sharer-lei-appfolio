require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image_url__valid
    image = Image.new(web_url: 'https://imgur.com/gallery/Lz2m84C')

    assert_predicate image, :valid?
  end

  def test_image_url__invalid_if_it_is_blank
    image = Image.new(web_url: '')

    refute_predicate image, :valid?
    assert_equal 'is an invalid URL', image.errors.messages[:web_url].first
  end

  def test_image_url__invalid_if_it_is_wrong_format
    image = Image.new(web_url: 'Hello world')

    refute_predicate image, :valid?
    assert_equal 'is an invalid URL', image.errors.messages[:web_url].first
  end

  def test_image_tag__null
    image = Image.new(web_url: 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg')

    assert_predicate image, :valid?
    assert_equal [], image.mytag_list
  end

  def test_image_tag__one
    image = Image.new(web_url: 'https://img.apmcdn.org/5d9c531be5686d2572bcab206df39a230c44f642/uncropped/a85434-20161213-cat.jpg')
    image.mytag_list.add('cute')

    assert_predicate image, :valid?
    assert_equal ['cute'], image.mytag_list
  end

  def test_image_tag__multiple
    image = Image.new(web_url: 'https://i.pinimg.com/474x/b4/bb/eb/b4bbeb2aaafd59040e56df10ad885b40.jpg')
    image.mytag_list.add('cute', 'panda')

    assert_predicate image, :valid?
    assert_equal %w[cute panda], image.mytag_list
  end

  def test_image_tag__parse
    image = Image.new(web_url: 'https://images-na.ssl-images-amazon.com/images/I/71kkMXAcLCL._SY355_.png')
    image.mytag_list.add('cute, panda, real', parse: true)

    assert_predicate image, :valid?
    assert_equal %w[cute panda real], image.mytag_list
  end
end

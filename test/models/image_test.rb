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
end

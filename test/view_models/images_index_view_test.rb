require 'test_helper'

class ImagesIndexViewTest < ActiveSupport::TestCase
  def test_index_page_title
    images_index_view = ImagesIndexView.new(search_tag: 'cute')
    assert_equal 'All Images with tag [cute]', images_index_view.index_page_title

    images_index_view = ImagesIndexView.new(search_tag: 'cat')
    assert_equal 'All Images with tag [cat]', images_index_view.index_page_title
  end

  def test_search_tag_blank
    images_index_view = ImagesIndexView.new(search_tag: '')
    assert images_index_view.search_tag_blank?

    images_index_view = ImagesIndexView.new(search_tag: nil)
    assert images_index_view.search_tag_blank?

    images_index_view = ImagesIndexView.new(search_tag: 'cat')
    assert_not images_index_view.search_tag_blank?
  end

  def test_index_page_title_blank
    images_index_view = ImagesIndexView.new(search_tag: '')
    assert_equal 'All Images', images_index_view.index_page_title

    images_index_view = ImagesIndexView.new(search_tag: nil)
    assert_equal 'All Images', images_index_view.index_page_title
  end
end

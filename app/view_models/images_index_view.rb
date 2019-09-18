class ImagesIndexView
  def initialize(search_tag:)
    @search_tag = search_tag
  end

  def index_page_title
    if search_tag_blank?
      'All Images'
    else
      format('All Images with tag [%<search_tag>s]', search_tag: @search_tag)
    end
  end

  def search_tag_blank?
    @search_tag.blank?
  end
end

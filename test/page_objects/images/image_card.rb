module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def web_url
        node.find('img')[:src]
      end

      def mytag_list
        node.find_all('.js-index-tag').map(&:text)
      end

      def click_tag!(tag_name)
        tags_to_click = node.find_all('.js-index-tag') do |e|
          e.text == tag_name
        end
        tags_to_click.first.click
        window.change_to(IndexPage)
      end
    end
  end
end

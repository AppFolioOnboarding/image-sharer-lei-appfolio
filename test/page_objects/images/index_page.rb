module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :all_images, locator: '#js-all-images', item_locator: '.js-one-image', contains: ImageCard do
        def view!
          node.click_on('Show')
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('Submit Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        all_images.each do |e|
          return true if e.web_url == url && (tags.nil? || e.mytag_list == tags)
        end
        false
      end

      def clear_tag_filter!
        PageObjects::Images::IndexPage.visit
      end
    end
  end
end

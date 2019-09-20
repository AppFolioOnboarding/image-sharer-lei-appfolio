module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def image_url
        node.find('img')[:src]
      end

      def tags
        node.find_all('.js-tag').map(&:text)
      end

      def delete
        node.find('#js-delete').click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.find('#js-delete').click
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.find('#back-to-index').click
        window.change_to(IndexPage)
      end
    end
  end
end

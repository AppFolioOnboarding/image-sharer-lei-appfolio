module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :web_url
        element :mytag_list
      end

      def create_image!(web_url: nil, mytag_list: nil)
        self.web_url.set(web_url) if web_url.present?
        self.mytag_list.set(mytag_list) if mytag_list.present?
        node.click_button('Submit')
        window.change_to(ShowPage, self.class)
      end
    end
  end
end

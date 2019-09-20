module PageObjects
  class Document < AePageObjects::Document
    def notice_message
      node.find('#notice').text
    end
  end
end

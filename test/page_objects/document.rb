module PageObjects
  class Document < AePageObjects::Document
    def flash_message(message_type)
      return node.find('#notice').text if message_type == :notice
    end
  end
end

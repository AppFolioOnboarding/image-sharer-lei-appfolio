class Image < ApplicationRecord
  validates :web_url, url: true
end

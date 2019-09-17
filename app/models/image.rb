class Image < ApplicationRecord
  acts_as_taggable_on :mytags

  validates :web_url, url: true
end

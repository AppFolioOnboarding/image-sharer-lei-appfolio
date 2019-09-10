class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def home
    @name = 'World'
  end
end

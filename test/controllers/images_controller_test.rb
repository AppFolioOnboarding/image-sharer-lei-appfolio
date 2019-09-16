require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path

    assert_response :ok
    assert_select 'h1', 'New Image URL'
    assert_select '.new_image'
    assert_select '.simple_form'
    assert_select '#new_image'
  end
end

require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'test view content' do
    get root_path
    assert_response :ok
    assert_select 'body', 'Click here to submit new image link!'
  end
end

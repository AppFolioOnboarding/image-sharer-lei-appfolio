require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'test view content' do
    get '/'
    assert_response :ok
    assert_select 'body', 'Hello World!'
  end
end

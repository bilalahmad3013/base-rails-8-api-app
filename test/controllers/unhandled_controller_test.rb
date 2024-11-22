require "test_helper"

class UnhandledControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unhandled_index_url
    assert_response :success
  end
end

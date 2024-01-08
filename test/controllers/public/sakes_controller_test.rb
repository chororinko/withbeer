require "test_helper"

class Public::SakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_sakes_index_url
    assert_response :success
  end

  test "should get show" do
    get public_sakes_show_url
    assert_response :success
  end
end

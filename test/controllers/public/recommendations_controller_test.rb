require "test_helper"

class Public::RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_recommendations_index_url
    assert_response :success
  end

  test "should get show" do
    get public_recommendations_show_url
    assert_response :success
  end
end

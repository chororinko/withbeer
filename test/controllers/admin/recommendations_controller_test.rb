require "test_helper"

class Admin::RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_recommendations_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_recommendations_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_recommendations_show_url
    assert_response :success
  end
end

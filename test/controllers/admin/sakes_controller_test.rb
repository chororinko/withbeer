require "test_helper"

class Admin::SakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sakes_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_sakes_edit_url
    assert_response :success
  end
end

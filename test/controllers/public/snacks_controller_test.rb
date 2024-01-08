require "test_helper"

class Public::SnacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_snacks_index_url
    assert_response :success
  end

  test "should get show" do
    get public_snacks_show_url
    assert_response :success
  end

  test "should get new" do
    get public_snacks_new_url
    assert_response :success
  end
end

require "test_helper"

class Public::RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_recipes_new_url
    assert_response :success
  end

  test "should get show" do
    get public_recipes_show_url
    assert_response :success
  end
end

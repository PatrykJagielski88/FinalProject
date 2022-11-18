require "test_helper"

class ProductDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get product_details_controller_url
    assert_response :success
  end

  test "should get index" do
    get product_details_index_url
    assert_response :success
  end

  test "should get show" do
    get product_details_show_url
    assert_response :success
  end
end

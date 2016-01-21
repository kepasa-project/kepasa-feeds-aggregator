require 'test_helper'

class MundosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

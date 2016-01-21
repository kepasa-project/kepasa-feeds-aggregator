require 'test_helper'

class VidaSaludosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

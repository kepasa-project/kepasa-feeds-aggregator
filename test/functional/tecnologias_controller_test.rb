require 'test_helper'

class TecnologiasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

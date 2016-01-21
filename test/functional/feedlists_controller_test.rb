require 'test_helper'

class FeedlistsControllerTest < ActionController::TestCase
  setup do
    @feedlist = feedlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedlists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedlist" do
    assert_difference('Feedlist.count') do
      post :create, feedlist: { feed_id: @feedlist.feed_id, guid: @feedlist.guid, image: @feedlist.image, name: @feedlist.name, published_at: @feedlist.published_at, rssurl: @feedlist.rssurl, summary: @feedlist.summary, url: @feedlist.url }
    end

    assert_redirected_to feedlist_path(assigns(:feedlist))
  end

  test "should show feedlist" do
    get :show, id: @feedlist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feedlist
    assert_response :success
  end

  test "should update feedlist" do
    put :update, id: @feedlist, feedlist: { feed_id: @feedlist.feed_id, guid: @feedlist.guid, image: @feedlist.image, name: @feedlist.name, published_at: @feedlist.published_at, rssurl: @feedlist.rssurl, summary: @feedlist.summary, url: @feedlist.url }
    assert_redirected_to feedlist_path(assigns(:feedlist))
  end

  test "should destroy feedlist" do
    assert_difference('Feedlist.count', -1) do
      delete :destroy, id: @feedlist
    end

    assert_redirected_to feedlists_path
  end
end

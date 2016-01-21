require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  setup do
    @feed = feeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feed" do
    assert_difference('Feed.count') do
      post :create, feed: { guid: @feed.guid, image: @feed.image, name: @feed.name, published_at: @feed.published_at, rssurl: @feed.rssurl, summary: @feed.summary, url: @feed.url, user_id: @feed.user_id }
    end

    assert_redirected_to feed_path(assigns(:feed))
  end

  test "should show feed" do
    get :show, id: @feed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feed
    assert_response :success
  end

  test "should update feed" do
    put :update, id: @feed, feed: { guid: @feed.guid, image: @feed.image, name: @feed.name, published_at: @feed.published_at, rssurl: @feed.rssurl, summary: @feed.summary, url: @feed.url, user_id: @feed.user_id }
    assert_redirected_to feed_path(assigns(:feed))
  end

  test "should destroy feed" do
    assert_difference('Feed.count', -1) do
      delete :destroy, id: @feed
    end

    assert_redirected_to feeds_path
  end
end

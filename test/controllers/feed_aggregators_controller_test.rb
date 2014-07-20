require 'test_helper'

class FeedAggregatorsControllerTest < ActionController::TestCase
  setup do
    @feed_aggregator = feed_aggregators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feed_aggregators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feed_aggregator" do
    assert_difference('FeedAggregator.count') do
      post :create, feed_aggregator: { name: @feed_aggregator.name }
    end

    assert_redirected_to feed_aggregator_path(assigns(:feed_aggregator))
  end

  test "should show feed_aggregator" do
    get :show, id: @feed_aggregator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feed_aggregator
    assert_response :success
  end

  test "should update feed_aggregator" do
    patch :update, id: @feed_aggregator, feed_aggregator: { name: @feed_aggregator.name }
    assert_redirected_to feed_aggregator_path(assigns(:feed_aggregator))
  end

  test "should destroy feed_aggregator" do
    assert_difference('FeedAggregator.count', -1) do
      delete :destroy, id: @feed_aggregator
    end

    assert_redirected_to feed_aggregators_path
  end
end

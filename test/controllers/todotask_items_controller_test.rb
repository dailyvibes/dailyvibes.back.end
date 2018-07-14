require 'test_helper'

class TodotaskItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todotask_item = todotask_items(:one)
  end

  test "should get index" do
    get todotask_items_url, as: :json
    assert_response :success
  end

  test "should create todotask_item" do
    assert_difference('TodotaskItem.count') do
      post todotask_items_url, params: { todotask_item: { archived_at: @todotask_item.archived_at, duedate_at: @todotask_item.duedate_at, title: @todotask_item.title } }, as: :json
    end

    assert_response 201
  end

  test "should show todotask_item" do
    get todotask_item_url(@todotask_item), as: :json
    assert_response :success
  end

  test "should update todotask_item" do
    patch todotask_item_url(@todotask_item), params: { todotask_item: { archived_at: @todotask_item.archived_at, duedate_at: @todotask_item.duedate_at, title: @todotask_item.title } }, as: :json
    assert_response 200
  end

  test "should destroy todotask_item" do
    assert_difference('TodotaskItem.count', -1) do
      delete todotask_item_url(@todotask_item), as: :json
    end

    assert_response 204
  end
end

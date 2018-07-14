require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
  end

  test "should get index" do
    get lists_url, as: :json
    assert_response :success
  end

  test "should create list" do
    assert_difference('List.count') do
      post lists_url, params: { list: { archived_at: @list.archived_at, color: @list.color, completed_at: @list.completed_at, duedate_at: @list.duedate_at, dv_default: @list.dv_default, emoji: @list.emoji, favourite: @list.favourite, public: @list.public, title: @list.title, title_description: @list.title_description, visible: @list.visible } }, as: :json
    end

    assert_response 201
  end

  test "should show list" do
    get list_url(@list), as: :json
    assert_response :success
  end

  test "should update list" do
    patch list_url(@list), params: { list: { archived_at: @list.archived_at, color: @list.color, completed_at: @list.completed_at, duedate_at: @list.duedate_at, dv_default: @list.dv_default, emoji: @list.emoji, favourite: @list.favourite, public: @list.public, title: @list.title, title_description: @list.title_description, visible: @list.visible } }, as: :json
    assert_response 200
  end

  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete list_url(@list), as: :json
    end

    assert_response 204
  end
end

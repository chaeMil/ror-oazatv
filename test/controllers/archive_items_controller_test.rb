require 'test_helper'

class ArchiveItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get archive_items_index_url
    assert_response :success
  end

  test "should get create" do
    get archive_items_create_url
    assert_response :success
  end

  test "should get new" do
    get archive_items_new_url
    assert_response :success
  end

  test "should get destroy" do
    get archive_items_destroy_url
    assert_response :success
  end

  test "should get show" do
    get archive_items_show_url
    assert_response :success
  end

end

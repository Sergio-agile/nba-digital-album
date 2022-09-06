require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get cards" do
    get albums_cards_url
    assert_response :success
  end

  test "should get quizzes" do
    get albums_quizzes_url
    assert_response :success
  end
end

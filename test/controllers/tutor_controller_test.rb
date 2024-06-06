require "test_helper"

class TutorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tutor_index_url
    assert_response :success
  end
end

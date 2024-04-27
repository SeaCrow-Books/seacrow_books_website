require "test_helper"

class EmailCapturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_capture = email_captures(:one)
  end

  test "should get index" do
    get email_captures_url
    assert_response :success
  end

  test "should get new" do
    get new_email_capture_url
    assert_response :success
  end

  test "should create email_capture" do
    assert_difference("EmailCapture.count") do
      post email_captures_url, params: { email_capture: { email: @email_capture.email } }
    end

    assert_redirected_to email_capture_url(EmailCapture.last)
  end

  test "should show email_capture" do
    get email_capture_url(@email_capture)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_capture_url(@email_capture)
    assert_response :success
  end

  test "should update email_capture" do
    patch email_capture_url(@email_capture), params: { email_capture: { email: @email_capture.email } }
    assert_redirected_to email_capture_url(@email_capture)
  end

  test "should destroy email_capture" do
    assert_difference("EmailCapture.count", -1) do
      delete email_capture_url(@email_capture)
    end

    assert_redirected_to email_captures_url
  end
end

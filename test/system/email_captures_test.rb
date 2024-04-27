require "application_system_test_case"

class EmailCapturesTest < ApplicationSystemTestCase
  setup do
    @email_capture = email_captures(:one)
  end

  test "visiting the index" do
    visit email_captures_url
    assert_selector "h1", text: "Email captures"
  end

  test "should create email capture" do
    visit email_captures_url
    click_on "New email capture"

    fill_in "Email", with: @email_capture.email
    click_on "Create Email capture"

    assert_text "Email capture was successfully created"
    click_on "Back"
  end

  test "should update Email capture" do
    visit email_capture_url(@email_capture)
    click_on "Edit this email capture", match: :first

    fill_in "Email", with: @email_capture.email
    click_on "Update Email capture"

    assert_text "Email capture was successfully updated"
    click_on "Back"
  end

  test "should destroy Email capture" do
    visit email_capture_url(@email_capture)
    click_on "Destroy this email capture", match: :first

    assert_text "Email capture was successfully destroyed"
  end
end

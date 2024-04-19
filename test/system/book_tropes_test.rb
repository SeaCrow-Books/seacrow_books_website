require "application_system_test_case"

class BookTropesTest < ApplicationSystemTestCase
  setup do
    @book_trope = book_tropes(:one)
  end

  test "visiting the index" do
    visit book_tropes_url
    assert_selector "h1", text: "Book tropes"
  end

  test "should create book trope" do
    visit book_tropes_url
    click_on "New book trope"

    fill_in "Name", with: @book_trope.name
    fill_in "Slug", with: @book_trope.slug
    click_on "Create Book trope"

    assert_text "Book trope was successfully created"
    click_on "Back"
  end

  test "should update Book trope" do
    visit book_trope_url(@book_trope)
    click_on "Edit this book trope", match: :first

    fill_in "Name", with: @book_trope.name
    fill_in "Slug", with: @book_trope.slug
    click_on "Update Book trope"

    assert_text "Book trope was successfully updated"
    click_on "Back"
  end

  test "should destroy Book trope" do
    visit book_trope_url(@book_trope)
    click_on "Destroy this book trope", match: :first

    assert_text "Book trope was successfully destroyed"
  end
end

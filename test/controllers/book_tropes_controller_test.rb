require "test_helper"

class BookTropesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_trope = book_tropes(:one)
  end

  test "should get index" do
    get book_tropes_url
    assert_response :success
  end

  test "should get new" do
    get new_book_trope_url
    assert_response :success
  end

  test "should create book_trope" do
    assert_difference("BookTrope.count") do
      post book_tropes_url, params: { book_trope: { name: @book_trope.name, slug: @book_trope.slug } }
    end

    assert_redirected_to book_trope_url(BookTrope.last)
  end

  test "should show book_trope" do
    get book_trope_url(@book_trope)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_trope_url(@book_trope)
    assert_response :success
  end

  test "should update book_trope" do
    patch book_trope_url(@book_trope), params: { book_trope: { name: @book_trope.name, slug: @book_trope.slug } }
    assert_redirected_to book_trope_url(@book_trope)
  end

  test "should destroy book_trope" do
    assert_difference("BookTrope.count", -1) do
      delete book_trope_url(@book_trope)
    end

    assert_redirected_to book_tropes_url
  end
end

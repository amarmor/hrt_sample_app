require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links as logged out user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links as logged in user" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    assert_select "a[href=?]", users_path
    get users_path
    assert_select "title", full_title("All users")
   #assert_select "a[href=?]", current_user
    assert_select "a[href=?]", edit_user_path(@user) #Doesn't work
    get edit_user_path(@user) #Doesn't work
    assert_select "title", full_title("Edit user") # Doesn't work
    assert_select "a[href=?]", logout_path
    get signup_path # will only pass if logout successful
    assert_select "title", full_title("Sign up") # will verify that previous line successful
  end
end

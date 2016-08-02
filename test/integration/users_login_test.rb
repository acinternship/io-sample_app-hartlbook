require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in? # logout part

    assert_redirected_to @user # Check the right redirect target
    follow_redirect! # Actually visit the target page
    assert_template 'users/show'
    # Verifies that the login link disappears by verifying that there are zero login path links on the page
    assert_select "a[href=?]", login_path, count: 0 
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

		# logout part
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  # test "the truth" do
  #   assert true
  # end
end

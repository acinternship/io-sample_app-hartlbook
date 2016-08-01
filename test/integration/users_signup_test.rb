require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get signup_path # visit signup
		assert_no_difference 'User.count' do
			assert_select 'form[action="/signup"]'
			post signup_path, params: { user: { name: "", 
																				 email: "user@invalid",
																				 password: "foo",
																				 password_confirmation: "bar" } }
		end
		assert_template 'users/new' # call to check that a failed submission re-renders the new action
		assert_select '.form-control' # check if the page uses .form-control css class (select)
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post signup_path, params: { user: { name: "Example User", 
																				 email: "user@valid.com",
																				 password: "foobar",
																				 password_confirmation: "foobar" } }						
		end
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
	end
  # test "the truth" do
  #   assert true
  # end
end

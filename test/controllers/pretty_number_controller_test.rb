require 'test_helper'

class PrettyNumberControllerTest < ActionController::TestCase
	def setup
		@controller = PrettyNumbersController.new
		@request.env["devise.mapping"] = Devise.mappings[:users]
	end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:pretty_numbers)
  end

  test "should get pretty" do
  	post :prettify, number: {value: '1234'}, :format => 'js'
  	assert_response :success
  end

  test "should create pretty" do
  	assert_difference('PrettyNumber.count') do
    	post :create, pretty_number: {
    		name: 'Quadrillion',
    		abbreviation_name: 'Q',
    		number_min_length: 16,
    		number_max_length: 18
    	}
  	end
 
  	assert_redirected_to pretty_number_path(assigns(:pretty_number))
  end

  test "should not get new if not login" do
  	get :new
  	assert_response :redirect
  	assert_redirected_to new_user_session_path
  end

  test "should not get show if not login" do
  	get :show, id: '1'
  	assert_response :redirect
  	assert_redirected_to new_user_session_path
  end

  test "should not get edit if not login" do
  	get :edit, id: '1'
  	assert_response :redirect
  	assert_redirected_to new_user_session_path
  end

  test "should get new if user login" do
  	sign_in User.first
  	get :new
  	assert_response :success
  	assert_template :new
  end

  test "should get show if user login" do
  	sign_in User.first
  	get :show, id: pretty_numbers(:one).id
  	assert_response :success
  	assert_template :show
  end

  test "should get edit if user login" do
  	sign_in User.first
  	get :edit, id: pretty_numbers(:one).id
  	assert_response :success
  	assert_template :edit
  end

end

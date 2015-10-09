require 'test_helper'

class PrettyNumberControllerTest < ActionController::TestCase
	def setup
		@controller = PrettyNumbersController.new
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
end

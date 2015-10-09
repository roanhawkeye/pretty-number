require 'test_helper'

class PrettyNumberTest < ActiveSupport::TestCase

  test "should not save empty pretty number" do
  	pretty_number = PrettyNumber.new
  	assert_not pretty_number.save
  end

  test "should not save without name" do
  	pretty_number_params = {
  		name: '',
  		abbreviation_name: 'Q',
    	number_min_length: 16,
    	number_max_length: 18,
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)

  	assert_not pretty_number.save
  end

  test "should not save without abbreviation_name" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: '',
    	number_min_length: 16,
    	number_max_length: 18,
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)

  	assert_not pretty_number.save
  end

  test "should not save without number_min_length" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'Q',
    	number_max_length: 18,
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)

  	assert_not pretty_number.save
  end

  test "should not save without number_max_length" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'M',
    	number_min_length: 16,
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)

  	assert_not pretty_number.save
  end

  test "should save if all fields presents" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'Q',
    	number_min_length: 16,
    	number_max_length: 18
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)
  	assert pretty_number.save
  end

  # The defaulta Million, Billion and Trillion are already load to test database
  test "Should not save if not unique name" do
  	pretty_number_params = {
  		name: 'Million',
  		abbreviation_name: 'Q',
    	number_min_length: 16,
    	number_max_length: 18
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)
  	assert_not pretty_number.save
  end

  test "Should not save if not unique abbreviation_name" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'B',
    	number_min_length: 16,
    	number_max_length: 18
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)
  	assert_not pretty_number.save
  end

  test "Should not save if not unique number_min_length" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'Q',
    	number_min_length: 7,
    	number_max_length: 18
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)
  	assert_not pretty_number.save
  end

  test "Should not save if not unique number_max_length" do
  	pretty_number_params = {
  		name: 'Quatrillion',
  		abbreviation_name: 'Q',
    	number_min_length: 16,
    	number_max_length: 9
  	}

  	pretty_number = PrettyNumber.new(pretty_number_params)
  	assert_not pretty_number.save
  end
end

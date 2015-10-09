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

  test "get_available_scale return all pretty_number in database" do
  	#Count actual pretty_number register in database
  	expected_scales_retrieve = PrettyNumber.all.count

  	all_scales = PrettyNumber.get_available_scales().count
  
  	assert_equal(expected_scales_retrieve, all_scales) 
  end

  test "clean_number should truncate decimal part of number and return string" do
  	
  	sample_number = 1234.23
  	expected_number = '1234'
  	clean_number = PrettyNumber.clean_number(sample_number)
  	assert_equal(expected_number, clean_number)
  
  end

  test "prettify should return no decimal and appropiate scale" do
  	sample_number = '1000000'
  	expected_pretty_version = '1M'
  	pretty_version = PrettyNumber.prettify(sample_number)
  	assert_equal(expected_pretty_version, pretty_version)
  end

  test "prettify should return decimal and appropiate scale" do
  	sample_number = '2500000.34'
  	expected_pretty_version = '2.5M'
  	pretty_version = PrettyNumber.prettify(sample_number)
  	assert_equal(expected_pretty_version, pretty_version)
  end

  test "prettify should return same integer number if less than 6 digits length" do
  	sample_number = '532'
  	expected_pretty_version = '532'
  	pretty_version = PrettyNumber.prettify(sample_number)
  	assert_equal(expected_pretty_version, pretty_version)
  end

  test "prettify should return truncate number just one decimal with apropiate scale if lot of diferent number" do
  	sample_number = '1123456789'
  	expected_pretty_version = '1.1B'
  	pretty_version = PrettyNumber.prettify(sample_number)
  	assert_equal(expected_pretty_version, pretty_version)
  end
end

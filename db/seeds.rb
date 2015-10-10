# Initial Data to fill database, this seed must be load with any restore of database
# App supports nativaly Million, Billion and Trillion to prettify numbers in short scale

million_scale_params = {
	name: 'Million',
	abbreviation_name: 'M',
    number_min_length: 7,
    number_max_length: 9,
}

billion_scale_params = {
	name: 'Billion',
	abbreviation_name: 'B',
    number_min_length: 10,
    number_max_length: 12,
}

trillion_scale_params = {
	name: 'Trillion',
	abbreviation_name: 'T',
    number_min_length: 13,
    number_max_length: 15,
}

pretty_numbers = [
	million_scale_params,
	billion_scale_params,
	trillion_scale_params
]

pretty_numbers.each do |pretty_number|
	PrettyNumber.create(pretty_number)
end
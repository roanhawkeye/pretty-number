class PrettyNumber < ActiveRecord::Base
	validates :name, :abbreviation_name, :number_min_length, :number_max_length, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	validates :number_min_length, :number_max_length, uniqueness: true

	def self.prettify(raw_number)
		number = self.clean_number(raw_number)

		# Cache length in order to do not calculate it with every iteration
		number_length = number.length
		
		#Number need at least 7 digits in order to be prettify with an scale
		if number_length <= 6
			return number
		else
			return self.find_pretty_version(number_length, number)
		end
	end

	private

		def self.get_available_scales
			self.all
		end

		# It cleans raw number for decimals part to be prepare for prettifying, returns a string
		def self.clean_number(raw_number)
			number = raw_number.to_i.to_s
		end

		#Reduces number to 1 decimal if need it, and append right notation
		def self.build_pretty_version(number, scale)
			# Cache variables to increase performance
			lenght_difference = number.length - scale.number_min_length
			scale_firt_decimal_index = lenght_difference + 1
			prettify_version = ''
			elements = []

			# truncate scale extra position before adding notation
			reduced_number = number[0,scale_firt_decimal_index]
			elements.append(reduced_number)

			#Verifies that an aditional decimal point and number is need it and add it
			if number[scale_firt_decimal_index].to_s != '0'
				elements.append(".#{number[scale_firt_decimal_index]}")
			end

			#Add scale notation to end of prettify version
			elements.append(scale.abbreviation_name)

			elements.each do |element|
				prettify_version += element
			end
			prettify_version
		end

		def self.find_pretty_version(number_length, number)
			scales = self.get_available_scales()

			scales.each do |scale|
				if number_length >= scale.number_min_length && number_length <= scale.number_max_length
					return self.build_pretty_version(number, scale)
				end
			end
			"Sorry, there is no available scale to prettify your number, please try again with different one"
		end
	end

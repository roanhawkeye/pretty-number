class PrettyNumber < ActiveRecord::Base
	validates :name, :abbreviation_name, :number_min_length, :number_max_length, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	validates :number_min_length, :number_max_length, uniqueness: true

	def self.prettify(raw_number)
		scales = self.get_available_scales()
		number = self.clean_number(raw_number)

		# Cache length in order to do not calculate it with every iteration
		number_length = number.length
		
		#Number need at least 7 digits in order to be prettify with an scale
		if number_length <= 6
			return number
		else
			# searchs for a fit scale
			scales.each do |scale|
				if number_length >= scale.number_min_length && number_length <= scale.number_max_length
					return self.build_pretty_version(number, scale)
				end
			end
		end
	end

	private

		def self.get_available_scales
			self.all
		end

		# It cleans raw number for decimals part, to be prepare to prettify
		def self.clean_number(raw_number)
			number = raw_number.to_i.to_s
		end

		#Reduces number to 1 decimal if need it, and append right notation
		def self.build_pretty_version(number, scale)
			lenght_difference = number.length - scale.number_min_length
			puts "lenght_difference: #{lenght_difference}"

			if lenght_difference >= 1
				reduced_number = number[0,lenght_difference + 1] + scale.abbreviation_name
			else
				reduced_number = number[0] + scale.abbreviation_name
			end
			puts reduced_number
			reduced_number
		end

	end

class PrettyNumber < ActiveRecord::Base
	validates :name, :abbreviation_name, :number_min_length, :number_max_length, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	validates :number_min_length, :number_max_length, uniqueness: true
end

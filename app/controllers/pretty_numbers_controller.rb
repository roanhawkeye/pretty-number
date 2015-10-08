class PrettyNumbersController < ApplicationController

	def index
		@pretty_numbers = PrettyNumber.all
	end

	def prettify

		respond_to do |format|
	      format.js   { render :action => "prettify" }
	    end
	end
end

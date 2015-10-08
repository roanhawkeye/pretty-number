class PrettyNumbersController < ApplicationController

	def index
		@pretty_numbers = PrettyNumber.all
	end

	def prettify		
		@result = PrettyNumber.prettify(params[:number][:value])
		respond_to do |format|
	      format.js   { render :action => "prettify" }
	    end
	end
end

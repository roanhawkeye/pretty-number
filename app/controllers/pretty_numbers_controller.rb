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

	def show
		@pretty_number = PrettyNumber.find(params[:id])
	end

	def new
		@pretty_number = PrettyNumber.new
	end

	def edit
		@pretty_number = PrettyNumber.find(params[:id])
	end

	def create
		@pretty_number = PrettyNumber.new(pretty_number_params)

		if @pretty_number.save
			redirecto_to @pretty_number
		else
			render 'new'
		end
	end

	def update
		@pretty_number = PrettyNumber.find(params[:id])

		if @pretty_number.update
			redirecto_to @pretty_number
		else
			render 'edit'
		end
	end

	def destroy
		@pretty_number = PrettyNumber.find(params[:id])
		@pretty_number.destroy

		redirecto_to pretty_numbers_path
	end

	private

		def pretty_number_params
			params.require(:pretty_number).permit(
				:name,
				:abbreviation_name,
				:number_min_length,
				:number_max_length
			)
		end
end

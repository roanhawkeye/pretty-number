class Api::V1::PrettyNumbersController < ApplicationController
	respond_to :json
	before_action :authenticate

	def index
		respond_with PrettyNumber.all
	end

	def show
		begin
			respond_with PrettyNumber.find(params[:id])
		rescue Exception => e
    		render json: { error: "caught exception: #{e}!"}
  		end
	end

	def prettify
		begin		
			result = PrettyNumber.prettify(params[:number][:value])
			render json: {pretty_version: result}, status: 200
		rescue Exception => e
    		render json: { error: "caught exception: #{e}!"}
  		end
	end

	def create
		pretty_number = PrettyNumber.new(pretty_number_params)

		if pretty_number.save
			render json: pretty_number, status: 201
		else
			render json: { error: pretty_number.errors , status: 422}
		end
	end

	def update
		begin
			pretty_number = PrettyNumber.find(params[:id])

			if pretty_number.update(pretty_number_params)
				render json: pretty_number, status: 200
			else
				render json: {error: pretty_number.errors}, status: 400
			end
		rescue Exception => e
    		render json: { error: "caught exception: #{e}!"}
  		end
	end

	def destroy
		begin
			pretty_number = PrettyNumber.find(params[:id])
			pretty_number.destroy
			head 204
		rescue Exception => e
    		render json: { error: "caught exception: #{e}!"}
  		end
	end

	protected
	    def authenticate
	      authenticate_token || render_unauthorized
	    end

	    def authenticate_token
	      authenticate_with_http_token do |token, options|
	        if token != Rails.application.secrets.api_token
	        	return false
	        end
	        return true
	      end
	    end

	    def render_unauthorized
	      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
	      render json: 'Bad credentials', status: 401
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
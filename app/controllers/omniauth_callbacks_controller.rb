class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
	      @user = User.from_omniauth(request.env["omniauth.auth"])

	      if @user.persisted?
	        flash[:info] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	        sign_in_and_redirect @user, :event => :authentication
	      else
	        session["devise.google_data"] = request.env["omniauth.auth"]
	        redirect_to new_user_registration_url
	      end
  	end

  	def twitter
	    auth = env["omniauth.auth"]

	    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)
	    
	    if @user.persisted?
	      flash[:info] = I18n.t "devise.omniauth_callbacks.success"
	      sign_in_and_redirect @user, :event => :authentication
	    else
	      session["devise.twitter_uid"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
  	end

  	def github
  		@user = User.from_omniauth(request.env["omniauth.auth"])

  		if @user.persisted?
  			flash[:info] = I18n.t "devise.omniauth_callbacks.success"
  			sign_in_and_redirect @user, :event => :authentication
  		else
  			session["devise.github_data"] = request.env["omniauth.auth"]
  			redirect_to new_user_registration_url
  		end
  	end

end
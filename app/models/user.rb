class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
		  :recoverable, :rememberable, :trackable, :validatable,
		  :omniauthable, :omniauth_providers => [:google_oauth2, :twitter, :github]

  def self.from_omniauth(access_token)
  	data = access_token.info
  	user = User.where(:email => data["email"]).first

  	unless user
  		user = User.create(
  			email: data["email"],
  			password: Devise.friendly_token[0,20]
  			)
  	end

  	user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	if user
  		return user
  	else
  		registered_user = User.where(:email => auth.uid + "@twitter.com").first
  		if registered_user
  			return registered_user
  		else

  			user = User.create(
  				provider:auth.provider,
  				uid:auth.uid,
  				email:auth.uid+"@twitter.com",
  				password:Devise.friendly_token[0,20],
  				)
  		end

  	end
  end

end

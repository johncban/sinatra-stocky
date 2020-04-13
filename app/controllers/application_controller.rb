class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

	# Project Configuration
	configure do
		set :views, "app/views"
		set :public_folder, 'public'
		enable :sessions
		set :session_secret, "password_security"
		register Sinatra::Flash
	end


	# Display root or index page of the new or existing user.
	get "/" do
		erb :index
	end

	# App helpers
	helpers do

		# Checks if user is logged in through session.
		def logged_in?
			!!session[:user_id]
		end

		# Checks if user have a valid session.
		def not_log_redirect
			if !logged_in?
				flash[:no_log_signup] = "Please Sign Up or Log In - Error Code: #{response.status}"
				redirect '/'
			end
		end
		
		# Redirects the user to home page.
		def portfolio_redirect
			redirect to '/home'
		end

		# Checks user for admin rights.
		def admin?
			session[:admin]
		end
		
		# Only users with admin session can delete.
		def deleteprofile?
			session[:admin]
		end
		
		# Admin session checker.
		def admin!
		  	if current_user.admin == nil
		  		flash[:error] = "For Admin Users Only. You are not authorized to see this page! - Error Code: #{response.status}"
		  		redirect '/home'
		  	end
		end
		
		# Checks user if it have rights to delete a profile.
		def deleteprofile!
			if current_user.admin == nil
			  flash[:error] = "Please email the admin for profile deletion - Error Code: #{response.status}"
			  redirect '/home'
			end
		end
		
		# Checks current user's session.
		def current_user
			User.find_by_id(session[:user_id])
		end
				
	end

end

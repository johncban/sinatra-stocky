require 'pry'


class UserController < ApplicationController

	token = ""

	
	get "/signup" do
		erb :'/index'
	end


	post "/signup" do
        if params[:username].empty?
			flash[:regnoname] = "Enter Signup Name - Error Code #{response.status}"
            redirect '/'
        elsif params[:email].empty?
			flash[:regnoemail] = "Enter Proper Signup Email - Error Code #{response.status}"			
			redirect '/'
        elsif params[:password].empty?
			flash[:regnopass] = "Enter Signup Password - Error Code #{response.status}"
            redirect '/'
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
			if @user.save
				flash[:user_success] = "User Successfully Created - Response Code #{response.status}"
                redirect "/"
			else
				flash[:user_failed] = "User Failed to Generate - Error Code #{response.status}"
                redirect "/"
            end
        end
	end


	get "/signupuser" do
		if !current_user
			flash[:nouser] = "Please Sign Up or Log In - Error Code #{response.status}"
			not_log_redirect
		else
			admin! 
			@user = User.all
			erb :'/users/signup'
		end
	end


	post "/signupuser" do
        if params[:username].empty?
            flash[:regnoname] = "Enter Signup Name - Error Code #{response.status}"
            redirect '/signupuser'
        elsif params[:email].empty?
            flash[:regnoemail] = "Enter Signup Email - Error Code #{response.status}"
            redirect '/signupuser'
        elsif params[:password].empty?
            flash[:regnopass] = "Enter Signup Password - Error Code #{response.status}"
            redirect '/signupuser'
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
			if @user.save
				flash[:user_success] = "User Successfully Created - Response Code #{response.status}"
                redirect "/users"
            else
                redirect "/"
            end
        end
	end


	get "/login" do
		erb :'/index'
	end


	post "/login" do
		@user = User.find_by(:username => params[:username])
        if params[:username].empty?
            flash[:lognoname] = "Enter Login Name - Error Code #{response.status}"
            redirect '/'
        elsif params[:password].empty?
            flash[:lognopass] = "Enter Login Password - Error Code #{response.status}"
            redirect '/'
        elsif @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
			redirect "/home"
		else
			flash[:warning] = "Please Sign Up or Log In - Error Code #{response.status}"
			not_log_redirect
        end
	end


	get '/users/:id' do
		@user = User.find_by_id(params[:id])
		if @user
			if logged_in? 
				@user = User.find_by_id(params[:id])
				erb :'/users/profile'
			else
				flash[:nocredential] = "Please Sign Up or Log in - Error Code #{response.status}"
				not_log_redirect
			end
		else
			#flash[:nouser] = "No User - Error Code #{response.status}"
      		redirect '/home'
		end
	end


	get '/users/:id/edit' do
		@user = User.find_by_id(params[:id])
		if @user 
			if logged_in? 
				@user = User.find_by_id(params[:id])
				if @user.id == current_user.id
					erb :'/users/edit'
				else
					flash[:not_current_user] = "You don't have permission to edit other user's profile - Error Code #{response.status}"
					redirect '/home'
				end
			else
				not_log_redirect
			end
		else
			flash[:nouser] = "No User - Error Code #{response.status}"
      		redirect '/home'
		end
	end


	patch '/users/:id' do
		@user = User.find_by_id(params[:id])
		if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
			@user = User.find(params[:id])
			@user.update(username:params[:username], email:params[:email], password:params[:password])
			flash[:profile_message] = "Account Updated"
			redirect '/home'
		else
			flash[:profile_form_message] = "Please don't leave the profile edit form blank - Error Code #{response.status}"
			redirect '/home'
		end
	end


	get '/users' do
		if !current_user
			flash[:nouser] = "Please Sign Up or Log In - Error Code #{response.status}"
			not_log_redirect
		else
			admin! 
			@user = User.all
			erb :'/admin/allusers'
		end
	end


	delete '/users/:id' do
		deleteprofile!
		  @user = User.find(params[:id])
		  
		  if @user.present?
			@user.destroy
			flash[:deluser] = "User Successfully Deleted - Response Code #{response.status}"
		  end 
				redirect to '/users'
	end

	
	get '/home' do
		if logged_in?
			@user = User.find(session[:user_id])

			sector = Alphavantage::Sector.new key: token 

			@relTime = sector.real_time_performance
			@fiveDay = sector.five_day_performance
			
			erb :home
		else
			not_log_redirect
		end
	end
	

	get "/logout" do
		session.clear
		redirect "/"
	end


end

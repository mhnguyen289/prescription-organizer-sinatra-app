require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
	  set :views, 'app/views'
	  enable :sessions
	  set :session_secret, "pillcollection"
	end


	get '/' do
   	redirect "/login"
  	end

  helpers do

  	def logged_out?
			if !logged_in?
				redirect '/login?error=Please LOG IN to view that content'
			end
		end

  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		User.find(session[:user_id])
  	end

	def error
		@error_message = params[:error]
	end
  end

end
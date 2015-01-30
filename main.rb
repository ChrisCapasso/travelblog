require 'sinatra'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep

set :sessions, true

# session[:user_id] = @user.id

get '/' do
	erb :signin
end

post '/sign-in' do
	@user = User.where(username: params[:username]).first
	if @user.password == params[:password]
		redirect '/my_profile'
	else
		redirect '/'
	end
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end
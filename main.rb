require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require_relative './models.rb'
enable :sessions
use Rack::Flash, :sweep

set :database, "sqlite3:data.sqlite3"
set :sessions, true

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















































get '/recent' do
	@posts = Post.find(5).reverse
	erb :recent
end


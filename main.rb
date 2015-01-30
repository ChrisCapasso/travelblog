require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require_relative './models.rb'

# enable :sessions
# use Rack::Flash, :sweep

set :database, "sqlite3:data.sqlite3"
# set :sessions, true

get '/' do
	erb :signin
end

post '/signin' do
	@user = User.where(username: params[:username]).first
	if @user.password == params[:password]
		redirect '/my_profile'
	else
		redirect '/'
	end
end

get '/feed' do
	erb :feed
end

get '/my_account' do
	erb :my_account
end

get '/my_profile' do
	erb :my_profile
end

get '/profiles' do
	erb :profiles
end

get '/signup' do
	erb :signup
end

get '/add_post' do
	erb :add_post
end

post '/add_post' do
	Post.create(params[:post])
	flash[:notice]="New post created."
	redirect to '/'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

get '/follow/:id' do
	@relationship = Relationship.new(follower_id: current_user.id, 
									 followed_id: params[:id])
	if @relationship.save
		flash[:notice]="You've successfully followed"
	else
		flash[:alert]="There was a problem."
	end
	redirect back
end
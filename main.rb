require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require_relative './models.rb'

enable :sessions
use Rack::Flash, :sweep =>true

set :database, "sqlite3:data.sqlite3"
set :sessions, true

get '/' do
	erb :signin
end

get '/signin' do
	erb :signin
end

post '/signin' do
	@user = User.where(username: params[:username]).first
	if @user and @user.password == params[:password]
		flash[:notice]="Successfully signed in."
		session[:user_id]=@user.id
		redirect to('/my_profile')
	else
		flash[:notice]="There was a problem logging in"
		redirect to ('/')
	end
end

get '/success' do
	"You logged in successfully"
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

post '/signup' do
	User.create(params[:user])
	flash[:notice]="Welcome to Eyeglobe!"
	redirect to '/my_profile'
end

get '/add_post' do
	erb :add_post
end

post '/add_post' do
	Post.create(params[:post])
	flash[:notice]="New post created."
	redirect to '/my_profile'
end

def current_user
	if session[:user_id]
	@user=User.find(session[:user_id])
	else
	nil
	end
end

get '/recent' do
	@posts = Post.find(5).reverse
	erb :recent
end

get '/signout' do
	session[:user_id]=nil
	flash[:notice]="Come back soon!"
	redirect to ('/')
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


#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "berl.db"}

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

get '/' do
	@posts = Post.order 'created_at DESC'
	erb :index			
end

get '/new' do
	@p = Post.new
	erb :new
end

post '/new' do
	@p = Post.new params[:post]

	if @p.save
		erb "<h2>Thanx!</h2>"
	else
		@error = @p.errors.full_messages.first
		erb :new
	end

	redirect to '/'
	erb "You typed: -- #{post[content]} --"
end

get '/details/:post_id' do
	post_id = params[:post_id]

	results = Post.where(id: post_id)
	@row = results[0]
	
	@comments = Comment.where(post_id: post_id.to_i).order(id: :desc)

	erb :details
end

post '/details/:post_id' do
	post_id = params[:post_id]
	@c = Comment.new params[:commentos]

	results = Post.where(id: post_id)
	@row = results[0]

	@comments = Comment.where(post_id: post_id.to_i).order(id: :desc)
	  
	@c.post_id = post_id
	if @c.save
		erb "<h2>Thanx!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :details
	end
	
	redirect to ('/details/' + post_id)
	
end
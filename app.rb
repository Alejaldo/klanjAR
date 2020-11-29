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

before do
	@posts = Post.order 'created_at DESC'
	@comments = Comment.order 'created_at DESC'
end

get '/' do
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

get '/details/:id' do
	@post_id = params[:id]
  	@post = Post.find(@post_id)
	erb :details
end

post '/details/:id' do
	@post_id = params[:id]
	@post = Post.find(@post_id)
	  
	@c = Comment.new params[:commentos]
	if @c.save
		erb "<h2>Thanx!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :details
	end
	
	redirect to ('/details/' + @post_id)
	
end
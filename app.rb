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
	
	@results = @db.execute 'select * from Posts order by id desc'
	
	erb :index			
end

get '/new' do
	erb :new
end

post '/new' do
	content = params[:content]
	username = params[:username]

	@db.execute 'insert into Posts (content, username, created_date) values (?, ?, datetime());', [content, username]

	redirect to '/'
	erb "You typed: -- #{content} --"
end

get '/details/:post_id' do
	post_id = params[:post_id]

	erb :details
end

post '/details/:post_id' do
	post_id = params[:post_id]
	comment = params[:comment]

	@db.execute 'insert into Comments (comment, created_date, post_id) values (?, datetime(), ?);', [comment, post_id]

	redirect to ('/details/' + post_id)
end
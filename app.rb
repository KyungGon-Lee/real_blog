require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.
require "sinatra/reloader"

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

#데이터 테이블을 만듬
class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!
User.auto_upgrade!

set :bind, '0.0.0.0' # 이거 쓰면 ruby app.rb 뒤에 -o 0.0.0.0 안써도 됨


get '/' do
  @post = Post.all.reverse

  erb :index
end


get '/abap' do
  Post.create(
    :title => params["title"],
    :body => params["content"]
  )
  redirect to '/'
end


get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )
  redirect to '/'
end

get '/admin' do
  @users = User.all.reverse
  # 모든 유저를 불러와
  # admin.erb 에서 모든 유저를 보여준다.
  erb :admin
end

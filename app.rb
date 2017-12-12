require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

set :bind, '0.0.0.0' # 이거 쓰면 ruby app.rb 뒤에 -o 0.0.0.0 안써도 됨


get '/' do
  @post = Post.all
  erb :index
end


get '/abap' do
  Post.create(
    :title => params["title"],
    :body => params["content"]
  )
end

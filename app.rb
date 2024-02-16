require 'sinatra'
require 'sinatra/base'
require 'bcrypt'
require_relative './models/blog_post'

class Public < Sinatra::Base
  get '/' do
    erb :home, :locals => {
      body_class: 'home'
    }
  end

  get '/academic/?' do
    erb :academic, :locals => {
      body_class: 'academic'
    }
  end

  get '/bio/?' do
    erb :bio
  end

  get '/portfolio/?' do
    erb :portfolio, :locals => {
      body_class: 'portfolio'
    }
  end

  get '/blog/?' do
    erb :blog, locals: {
      posts: BlogPost.order(:id => :desc).all,
      body_class: 'blog'
    }
  end
end

class Protected < Sinatra::Base
  use Rack::Auth::Basic do |username, password|
    my_pass = BCrypt::Password.new("$2a$10$z17TZ/jzUSIS4hebuCcKuewVE687qi7S6D2rZq/TCEHqLAQV8ALmu")
    username == 'tyler' && my_pass == password
  end

  get '/blog/?' do
    erb :admin_blog, locals: {
      posts: BlogPost.order(:id => :desc).all
    }
  end

  get '/blog/new/?' do
    erb :edit_post, locals: {
      post: nil
    }
  end

  post '/blog/new/?' do
    posts = BlogPost.order(:id => :desc).all
    posts[0].delete if posts.count >= 5
    BlogPost.create(params.merge(posted_date: Time.now))
    redirect '/admin/blog/'
  end

  get '/blog/edit/:id/?' do
    erb :edit_post, locals: {
      post: BlogPost.find(params[:id])
    }
  end

  post '/blog/edit/:id/?' do
    BlogPost.find(params[:id]).update(params.merge(posted_date: Time.now))
    redirect '/admin/blog/'
  end

  post '/blog/delete/:id/?' do
    BlogPost.find(params[:id]).delete
    redirect '/admin/blog/'
  end
end

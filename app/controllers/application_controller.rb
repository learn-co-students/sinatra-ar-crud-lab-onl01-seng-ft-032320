require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  
  end
  
  get '/articles' do 
    @articles = Article.all 
    erb :index
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end

  delete '/articles/:id' do 
    Article.find(params[:id]).destroy
    @articles = Article.all
    erb :index
  end

  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect "/articles/#{@article.id}"

  end
  
  post '/articles' do 
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end
end

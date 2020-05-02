
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    
  end

  get '/articles/new' do

    erb :new
  end

  post '/articles' do
    @article = Article.create(params)

    redirect "/articles/#{@article.id}"
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end



  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    
    erb :edit
  end

  patch '/articles/:id' do
    id = params[:id]
    @previous_post = Article.find(params[:id])
    @previous_post.update(title: params["title"], content: params["content"])
    @previous_post.save
    redirect "/articles/#{@article.id}"
  end


  delete '/articles/:id/delete' do
    @article = Article.find(params[:id])
    @article.delete

    erb :delete
  end
 
end

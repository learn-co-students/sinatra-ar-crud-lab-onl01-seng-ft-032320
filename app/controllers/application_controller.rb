
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
      erb :"../views/new"
  end

  post "/articles" do #create
    article = Article.create(params)

    if article.save
      redirect "/articles/#{article.id}"
    else 
      redirect "/articles/new"
    end 
    #binding.pry  
  end
  
  get "/articles" do 
    @articles = Article.all 
    erb :"../views/index"
  end 

  get "/articles/:id" do
    @article = Article.find_by_id(params[:id]) 
    erb :"../views/show"
  end 

  get "/articles/:id/edit" do
    @article = Article.find_by_id(params[:id])
    erb :"../views/edit"
  end 

  patch "/articles/:id" do 
    #binding.pry
    @article = Article.find_by_id(params[:id])
    
    if @article 
      @article.update(title: params[:title], content: params[:content])
      
      redirect "/articles/#{@article.id}"
    else 
      redirect "/articles/#{@article.id}/edit"
    end
    
  end 

  delete "/articles/:id/delete" do 
    @article = Article.find_by_id(params[:id])
    @article.destroy
     
    
  end 
end

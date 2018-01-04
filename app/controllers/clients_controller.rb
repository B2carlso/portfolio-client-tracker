class ClientsController < ApplicationController

  get '/clients' do
     if logged_in?
       @user = current_user
       @clients = Client.all
       erb :'clients/clients'
     else
       redirect to 'users/login'
     end
   end

   get '/clients/new' do

     if logged_in?
        erb :'clients/new'
      else
        redirect '/login'
      end
    end

    post '/clients' do
    if params[:name].empty?
      redirect "/clients/new"
    else
      @client = Client.create(:name => params[:name])
      @client.user_id = current_user.id

      @client.save
    end
  end

  get '/clients/:id' do
    if logged_in?
      @client = Client.find_by_id(params[:id])
      erb :'clients/show_client'
    else
      redirect '/login'
    end
  end

  get '/clients/:id/edit' do
    @client = Client.find_by_id(params[:id])
    if logged_in?
      erb :'clients/edit'
    else
      redirect '/login'
    end
  end

  patch '/clients/:id' do
    @client = Client.find_by_id(params[:id])
    unless params[:content].empty?
      @client.name = params[:name]
      @client.save
      erb :'clients/show_client'
    else
      redirect "/clients/#{@client.id}/edit"
    end
  end

  delete '/clients/:id/delete' do
    @client = Client.find_by_id(params[:id])
    if logged_in? && @client.user_id == current_user.id
      @client.delete
      redirect '/clients'
    else
      redirect '/login'
    end
  end
end

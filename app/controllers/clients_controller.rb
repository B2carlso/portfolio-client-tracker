class ClientsController < ApplicationController

  get '/clients' do
    if !logged_in?
      redirect to '/'
    else
      @clients = clients.all
      erb :'/clients/index'
    end
  end

  get '/clients/new' do
    if !logged_in?
      redirect to '/'
    else
      erb :'/clients/new'
    end
  end

  post '/clients' do
    client = Client.new(params[:client])
    client.user_id = session[:user_id]
    client.save
    if client.save
      redirect to "/clients/#{client.id}"
    else
      redirect to '/clients/new'
    end
  end

  get '/clients/:id' do
    if !logged_in?
      redirect to '/'
    else
      @client = Client.find(params[:id])
      @current_user = current_user
      erb :'/clients/show'
    end
  end

  get '/clients/:id/edit' do
    if !logged_in?
      redirect to '/'
    else
      if current_user.id == Client.find(params[:id]).user_id
        @client = Client.find(params[:id])
        erb :'/clients/edit'
      else
        redirect to "/clients/#{params[:id]}"
      end
    end
  end

  patch '/clients/:id' do
    if current_user.id == Client.find(params[:id]).user_id
      client = Client.find(params[:id])
      client.update(params[:client])
      if client.save
        redirect to "/clients/#{client.id}"
      else
        redirect to "/clients/#{client.id}/edit"
      end
    else
      redirect to "/clients/#{params[:id]}"
    end
  end

  delete '/clients/:id/delete' do
    if current_user.id == Client.find(params[:id]).user_id
      client = Client.find(params[:id])
      client.delete
      redirect to "/users/#{current_user.slug}"
    else
      redirect to "/clients/#{params[:id]}"
    end
  end
end

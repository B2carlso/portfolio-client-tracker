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

    #post '/clients' do
    #if params[:name].empty?
      #redirect "/clients/new"
    #else
      #@client = Client.create(:name => params[:name])
      #@client.user_id = current_user.id
      #@client = Client.create(name: params[:name], age: params[:age], user_id: current_user.id)

      #@client.save
    ##end
  #end

  #post '/clients' do
  #  if params[:name].empty?
    #  redirect '/clients/new'
  #  else
    #  @client = Client.create(name: params[:name], age: params[:age], user_id: current_user.id)
    #  redirect :"/clients/#{@client.id}"
  #  end
#  end

post "/clients" do
    if params[:name] != "" && params[:age] != ""
      if Client.find_by(name: params[:name] != nil)
        redirect "/clients/new"
      end

      clients = Client.new(name: params[:name], age: params[:age])
      user = current_user

      user.clients << clients
      user.save
      client.save
      redirect "/users/" + user.id.to_s
    else
      redirect "/clients/new"
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

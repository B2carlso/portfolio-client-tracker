require './config/environment'

class UsersController < ApplicationController


  get '/signup' do
    #binding.pry
    if !logged_in?
       erb :'users/new'
     else
        redirect to '/clients'
      end
    end

    post '/signup' do
      #binding.pry
     if params[:name] == "" || params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        @user.save

        session[:user_id] = @user.id
        redirect to '/clients'

       end
   end

    get '/login' do
     if logged_in?
       redirect to '/clients'
     else
       erb :'users/login'
     end
   end
end

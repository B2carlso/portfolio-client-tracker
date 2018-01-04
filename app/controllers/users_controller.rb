require './config/environment'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
   # binding.pry
    if !logged_in?
       erb :'trainers/new'
     else
        redirect to '/clients'
      end
    end

    post '/signup' do
     if params[:name] == "" || params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @trainer = Trainer.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        @trainer.save

        session[:trainer_id] = @trainer.id
        redirect to '/clients'

       end
   end

    get '/login' do
     if logged_in?
       redirect to '/clients'
     else
       erb :'trainers/login'
     end
   end
end

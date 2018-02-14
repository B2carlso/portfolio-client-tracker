require './config/environment'

class UsersController < ApplicationController


  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/clients'
    end
  end

  post '/signup' do
    if User.all.none?{|u| u.username == params[:user][:username]}
      user = User.create(params[:user])

      if user.save
        session[:user_id] = user.id
        redirect to "/users/#{current_user.slug}"
      else

        redirect to '/signup'
      end
    else
      flash[:notice] = "An account already exists with the provided Username."
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/clients'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.slug}"
    else
      flash[:notice] = "The Username / Password combination provided is invalid."
      redirect to'/login'
    end
  end

  get '/users/:slug' do
    if !logged_in?
      redirect to '/'
    else
      if current_user.slug == params[:slug]
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
      else
        redirect to "/users/#{current_user.slug}"
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
      redirect "/"
  end
end

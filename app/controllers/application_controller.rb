require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   set :session_secret, "trainer_client_tracker"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:trainer_id]
    end

    def current_trainer
      Trainer.find(session[:trainer_id])
    end
  end
end

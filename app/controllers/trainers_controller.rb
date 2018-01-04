require './config/environment'

class TrainersController < ApplicationController

  get '/signup' do
   # binding.pry
    if !logged_in?
       erb :'trainers/new'
     else
        redirect to '/clients'
      end

  end
end

class Trainer < ActiveRecord::Base

  has_many :clients
  has_secured_password
end

class Helpers

  def self.logged_in?(session)
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end

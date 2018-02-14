class User < ActiveRecord::Base

  has_many :clients
  has_secure_password

  validates_presence_of :username, :email, :password

  def slug
    self.username.gsub(/\s+/, '-').downcase
  end

  def self.find_by_slug(slug)
    self.find do |obj|
      obj.slug == slug
    end
  end
end

class User < ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  validates_presence_of :password_digest, confirmation: true
  validates_presence_of :password_confirmation, presence: true

  has_secure_password  
end 
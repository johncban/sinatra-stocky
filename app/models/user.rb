class User < ActiveRecord::Base
    has_secure_password
    
    validates_presence_of :username, :email, :password, uniqueness: true
    validates_uniqueness_of :username, scope: :id
    validates :email, email: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

    has_many :portfolios, :dependent => :destroy
    has_many :stocks
end

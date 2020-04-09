class User < ActiveRecord::Base
    has_secure_password
    
    validates_presence_of :username, :email, :password, uniqueness: true
    validates_uniqueness_of :username, scope: :id
    validates :email, email: true

    has_many :portfolios, :dependent => :destroy
    has_many :stocks
end

class Portfolio < ActiveRecord::Base

    belongs_to :user
    has_many :stocks, :dependent => :destroy

end
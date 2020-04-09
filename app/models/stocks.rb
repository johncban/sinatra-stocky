class Stocks < ActiveRecord::Base 
    belongs_to :user 
    belongs_to :portfolio
end

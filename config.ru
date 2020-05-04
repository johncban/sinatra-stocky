require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride



error do
  status 400
  "WARNING: REQUEST INVALID!"
end

error do
  status 401
  "WARNING: YOU ARE UNAUTHORIZED TO ACCESS THIS PAGE!"
end


not_found do
  status 404
  "Invalid Value or URL Address Available!"
end


error do 
  status 405
  "HTTP METHOD NOT ALLOWED"
end

error do 
  status 409
  "HTTP METHOD NOT ALLOWED"
end



use UserController
use PortfolioController
use StockController

run ApplicationController
run Sinatra::Application

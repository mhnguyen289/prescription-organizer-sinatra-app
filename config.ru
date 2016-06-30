require './config/environment'
require './app'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

run Sinatra::Application

use Rack::MethodOverride
use UsersController
use PillsController
use PrescriptionsController
use UsersController


run ApplicationController

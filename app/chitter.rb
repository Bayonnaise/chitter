require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require_relative 'models/user'
require_relative 'models/post'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'
require_relative 'messenger'

require_relative 'controllers/application'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/posts'

set :views, './app/views'
set :public_dir, './app/public'
enable :sessions
set :session_secret, 'mysession'
set :partial_template_engine, :erb

use Rack::Flash
use Rack::MethodOverride
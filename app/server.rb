require 'data_mapper'
require 'sinatra'
require './lib/link'
require './lib/tag'
require './lib/user'
require 'rack-flash'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'

use Rack::Flash

get '/' do
	@links = Link.all
	erb :index
end

post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
	Tag.first_or_create(:text => tag)
end
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end

get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end

get '/users/new' do
	# note the view is in views/users/new.erb
	# we need the quotes because otherwise
	# ruby would divide the symbol :users by the
	# variable new (which makes no sense)
	erb :"users/new"
end

post '/users' do
	# we just initialise the object
	# without saving it. It may be invalid
	@user = User.create(:email => params[:email],
						:password => params[:password],
						:password_confirmation => params[:password_confirmation])
	# lets try saving it
	# if the model is valid
	# it will be saved
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
		# if it's not valid,
		# we'll show the same
		# form again

	else 
		flash[:notice] = "Sorry, your passwords don't match"
		erb :"users/new"
	end

end

